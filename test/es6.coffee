# -*- coding: utf-8 -*-
#  Copyright (C) 2015 Yusuke Suzuki <utatane.tea@gmail.com>
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
#  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
#  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

'use strict'

Dumper = require './dumper'
harmony = require './third_party/esprima'
{expect} = require 'chai'
{traverse} = require '..'

describe 'rest expression', ->
    it 'argument', ->
        tree =
            type: 'RestElement'
            argument: {
                type: 'Identifier'
                name: 'hello'
            }

        expect(Dumper.dump(tree)).to.be.equal """
            enter - RestElement
            enter - Identifier
            leave - Identifier
            leave - RestElement
        """

describe 'class', ->
    it 'declaration#1', ->
        tree = harmony.parse """
        class Hello extends World {
            method() {
            }
        };
        """

        expect(Dumper.dump(tree)).to.be.equal """
            enter - Program
            enter - ClassDeclaration
            enter - Identifier
            leave - Identifier
            enter - Identifier
            leave - Identifier
            enter - ClassBody
            enter - MethodDefinition
            enter - Identifier
            leave - Identifier
            enter - FunctionExpression
            enter - BlockStatement
            leave - BlockStatement
            leave - FunctionExpression
            leave - MethodDefinition
            leave - ClassBody
            leave - ClassDeclaration
            enter - EmptyStatement
            leave - EmptyStatement
            leave - Program
        """

    it 'declaration#2', ->
        tree = harmony.parse """
        class Hello extends ok() {
            method() {
            }
        };
        """

        expect(Dumper.dump(tree)).to.be.equal """
            enter - Program
            enter - ClassDeclaration
            enter - Identifier
            leave - Identifier
            enter - CallExpression
            enter - Identifier
            leave - Identifier
            leave - CallExpression
            enter - ClassBody
            enter - MethodDefinition
            enter - Identifier
            leave - Identifier
            enter - FunctionExpression
            enter - BlockStatement
            leave - BlockStatement
            leave - FunctionExpression
            leave - MethodDefinition
            leave - ClassBody
            leave - ClassDeclaration
            enter - EmptyStatement
            leave - EmptyStatement
            leave - Program
        """

# vim: set sw=4 ts=4 et tw=80 :

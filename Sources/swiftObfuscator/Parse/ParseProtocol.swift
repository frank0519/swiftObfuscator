//
//  ParseProtocol.swift
//  swiftObfuscator
//
//  Created by He,Junqiu on 2018/2/24.
//

import Foundation
import SwiftSyntax

class ParserProtocol: SyntaxVisitor {
    var funcDecls = [FunctionExpression]()
    var variableDelcs = [PropertyExpression]()
    var accessLevel: ExpressionAccessLevel = .internal

    override func visit(_ node: StructDeclSyntax) {
        var accessLevel: ExpressionAccessLevel = .internal
        if let modifiers = node.modifiers {
            for modifier in modifiers {
                if let access = ExpressionAccessLevel(rawValue: modifier.name.description.trimmingCharacters(in: .whitespacesAndNewlines)) {
                    accessLevel = access
                }
            }
        }
        self.accessLevel = accessLevel
        return super.visit(node)
    }

    override func visit(_ node: VariableDeclSyntax) {
        var accessLevel: ExpressionAccessLevel = self.accessLevel
        node.modifiers?.forEach({
            if let val = ExpressionAccessLevel(rawValue: $0.description.trimmingCharacters(in: .whitespacesAndNewlines)) {
                accessLevel = val
            }
        })
        if let binding = node.bindings.first, let type = binding.typeAnnotation?.type.description {
            variableDelcs.append(PropertyExpression(accessLevel: accessLevel, name: binding.pattern.description, type: type))
        } else {
            Log("Can not parse protocol variable: \(node)")
            exit(1)
        }
        return super.visit(node)
    }

    override func visit(_ node: FunctionDeclSyntax) {
        funcDecls.append(FunctionExpression(superAccessLevel: accessLevel, modifiers: node.modifiers, attributes: node.attributes, name: node.identifier.description, signature: node.signature, parent: nil))
        return super.visit(node)
    }
}

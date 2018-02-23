//
//  ClassExpression.swift
//  swiftObfuscator
//
//  Created by He,Junqiu on 2018/1/30.
//

import Foundation
import SwiftSyntax

class ClassExpression: Expression {
    let name: String
    var exprType: ExpressionType { return .class }

    let inheritanceClause: TypeInheritanceClauseSyntax?
    var innested: Expression? = nil

    required init(name: String, inheritanceClause: TypeInheritanceClauseSyntax?) {
        self.name = name
        self.inheritanceClause = inheritanceClause
    }

    var methods = [FunctionExpression]()
    var properties = [PropertyExpression]()
}
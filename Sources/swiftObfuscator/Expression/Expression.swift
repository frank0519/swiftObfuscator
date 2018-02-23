//
//  Expression.swift
//  swiftObfuscator
//
//  Created by hejunqiu on 2018/2/23.
//

import Foundation

enum ExpressionType {
    case `class`, `struct`, `protocol`, `enum`
    case `func`, property
}

protocol Expression {
    var name: String { get }
    var exprType: ExpressionType { get }
}

extension Expression {
    var isClass: Bool { return exprType == .class }
    var isStruct: Bool { return exprType == .struct }
    var isProtocol: Bool { return exprType == .protocol }
    var isEnum: Bool { return exprType == .enum }
    var isFunc: Bool { return exprType == .func }
    var isProperty: Bool { return exprType == .property }
}
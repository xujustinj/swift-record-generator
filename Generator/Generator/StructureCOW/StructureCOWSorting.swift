//
//  StructureCOWSorting.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureCOWSorting(by element: Element, mutable: Bool) -> String {
    let sort = mutable ? "array.sort" : "let sorted = array.sorted"

    var criterion: String
    if element.isOptional {
        if element.wrapper == .none {
            criterion = """
            guard let lhs = $0.val.\(element.name), let rhs = $1.val.\(element.name) else { return false }
                    return lhs < rhs
            """
        } else {
            criterion = "$0.val.\(element.name)?.count ?? 0 < $1.val.\(element.name)?.count ?? 0"
        }
    } else {
        if element.wrapper == .none {
            criterion = "$0.val.\(element.name) < $1.val.\(element.name)"
        } else {
            criterion = "$0.val.\(element.name).count < $1.val.\(element.name).count"
        }
    }

    return """
    func structureCOW\(mutable ? _Var : _Let)Sorting(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) array = fill(ARRAY_SIZE) { Box(randomRecordStructure()) }
        \(GLOBAL_COUNTER) += array.count

        \(START_MEASURING)
        \(sort) {
            \(criterion)
        }
        \(END_MEASURING)
        \(INCREMENT_COUNTER)

        \(GLOBAL_COUNTER) += \(mutable ? "array" : "sorted").count
    }
    """
}

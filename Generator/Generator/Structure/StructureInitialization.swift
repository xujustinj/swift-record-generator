//
//  StructureInitialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureInitialization(with elements: [Element], mutable: Bool) -> String {
    let parameters = elements.map { "\($0.name): \($0.name)" }.joined(separator: ", ")

    let sanityChecks = elements.map { "guard record.\($0.name) == \($0.name) else { fatalError() }" }.joined(separator: "\n    ")

    return """
    func structure\(mutable ? _Var : _Let)Initialization(\(COUNTER_PARAMETER)) {
        \(GET_RANDOM_ELEMENTS(elements))

        \(START_MEASURING)
        \(mutable ? _var : _let) record = RecordStructure(\(parameters))
        \(END_MEASURING)
        \(INCREMENT_COUNTER)

        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(mutable ? "record = randomRecordStructure()" : "")
        \(MAKE_ARRAY())
    }
    """
}

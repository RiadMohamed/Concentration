//
//  Card.swift
//  Concentration
//
//  Created by Riad Mohamed on 10/11/18.
//  Copyright © 2018 Riad Mohamed. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniquieIdentifier () -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniquieIdentifier()
    }
}

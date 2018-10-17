//
//  Concentration.swift
//  Concentration
//
//  Created by Riad Mohamed on 10/11/18.
//  Copyright © 2018 Riad Mohamed. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        } set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                // check if cards match
                if cards[matchedIndex] == cards[index] {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 1
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): You chose a wrong number of pairs of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards.insert(card, at: cards.count.arc4random)
            cards.insert(card, at: cards.count.arc4random)
        }
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

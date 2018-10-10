//
//  ViewController.swift
//  Concentration
//
//  Created by Riad Mohamed on 10/10/18.
//  Copyright © 2018 Riad Mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            print("Card number: \(cardNumber)")
        } else {
            print("Card not in buttons array")
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    func flipCard(withEmohi emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
   
    
}


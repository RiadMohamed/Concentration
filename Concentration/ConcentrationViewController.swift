//
//  ViewController.swift
//  Concentration
//
//  Created by Riad Mohamed on 10/10/18.
//  Copyright © 2018 Riad Mohamed. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    struct Theme {
        let name: String
        let backgroundColor: UIColor
        let primaryColor: UIColor
        let secondaryColor: UIColor
    }
    
    var themes = [Theme]()
    
    func addThemes() {
        themes.append(Theme(name: "Halloween", backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), primaryColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        themes.append(Theme(name: "Barcelona", backgroundColor: #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), primaryColor: #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1), secondaryColor: #colorLiteral(red: 0, green: 0.4078431373, blue: 0.8549019608, alpha: 1)))
        themes.append(Theme(name: "Milan", backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), primaryColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        themes.append(Theme(name: "Chelsea", backgroundColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), primaryColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), secondaryColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
    }
    
    override func viewDidLoad() {
        print("viewDidLoad called")
        addThemes()
        currentTheme = themes[0]
        view.backgroundColor = currentTheme!.backgroundColor
        updateViewFromModel(currentTheme!)
        newGameButton.setTitleColor(currentTheme!.primaryColor, for: .normal)
    }
    
    let defaultTheme = Theme(name: "Default", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), primaryColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    var currentTheme: Theme? = nil
    


    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
        }
    }
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel(currentTheme ?? defaultTheme)
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel(currentTheme ?? defaultTheme)
        } else {
            print("Card not in buttons array")
        }
    }
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1)/2
    }

    
    private func updateViewFromModel(_ currentTheme: Theme) {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = currentTheme.secondaryColor
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme.primaryColor
                }
            }
            scoreLabel.text = "Score: \(game.score)"
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            if currentTheme != nil {
                updateViewFromModel(currentTheme!)
            }
        }
    }
    
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬👹👾🎩🌍"
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random )
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

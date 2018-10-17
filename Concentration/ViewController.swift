//
//  ViewController.swift
//  Concentration
//
//  Created by Riad Mohamed on 10/10/18.
//  Copyright © 2018 Riad Mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    let randomThemeSelector = 10.arc4random % 2
//    lazy var backgroundColor: UIColor = (randomThemeSelector == 0) ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//    lazy var faceDownColor: UIColor = (randomThemeSelector == 0) ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//    lazy var faceUpColor: UIColor = (randomThemeSelector == 0) ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    
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
        updateFlipCountLabel(currentTheme!)
        newGameButton.setTitleColor(currentTheme!.primaryColor, for: .normal)
    }
    
    let defaultTheme = Theme(name: "Default", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), primaryColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), secondaryColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    var currentTheme: Theme? = nil
    


    
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel(currentTheme ?? defaultTheme)
        }
    }
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
        updateViewFromModel(currentTheme ?? defaultTheme)
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
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
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel(currentTheme ?? defaultTheme)
        }
    }
    
    private func updateFlipCountLabel(_ currentTheme: Theme) {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth :5.0,
            .strokeColor: currentTheme.primaryColor
        ]
        let attributedString1 = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString1
    }
    
    private func updateViewFromModel(_ currentTheme: Theme) {
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

//
//  CardPartPagedViewCardController.swift
//  CardParts_Example
//
//  Created by Roossin, Chase on 5/23/18.
//  Copyright © 2018 Intuit. All rights reserved.
//

import Foundation
import CardParts
import Charts

class CardPartPagedViewCardController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait {
    func shadowColor() -> CGColor {
        return UIColor.lightGray.cgColor
    }
    
    func shadowRadius() -> CGFloat {
        return 5.0
    }
    
    func shadowOpacity() -> Float {
        return 0.5
    }
    
    func cornerRadius() -> CGFloat {
        return 10.0
    }
    
    
    let cardPartTextView = CardPartTextView(type: .normal)
    let emojis: [String] = ["😎", "🤪", "🤩", "👻", "🤟🏽", "💋", "💃🏽"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
        
        
        cardPartTextView.text = "These are new words for you to learn today:"
        
        var stackViews: [CardPartStackView] = []
        
        for _ in 0...10 {
            let word = lessonDict?.first
            
            let sv = CardPartStackView()
            sv.axis = .vertical
            sv.spacing = 8
            stackViews.append(sv)
            
            let title = CardPartTextView(type: .title)
            title.text = word?.key ?? "Sample"
            title.textAlignment = .center
            title.font = UIFont.boldSystemFont(ofSize: 25)
            sv.addArrangedSubview(title)
            
            let separator = CardPartSeparatorView()
            sv.addArrangedSubview(separator)
            
            let translation = CardPartTextView(type: .detail)
            translation.text = (word?.value as! String)
            translation.textAlignment = .center
            translation.font = UIFont.systemFont(ofSize: 20)
            sv.addArrangedSubview(translation)
            
            //let barView = BarChartView()
            //sv.addArrangedSubview(barView)
            
            let emoji = CardPartTextView(type: .normal)
            emoji.text = self.emojis[Int(arc4random_uniform(UInt32(self.emojis.count)))]
            emoji.textAlignment = .center
            sv.addArrangedSubview(emoji)
            
            lessonDict?.removeValue(forKey: word?.key ?? "Sample")
        }
        
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 170)
        
        setupCardParts([cardPartTextView, cardPartPagedView])
    }
}

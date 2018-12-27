//
//  CardChartViewController.swift
//  wordBeaver
//
//  Created by Fedor on 27/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts


class CardChartViewController: CardPartsViewController , ShadowCardTrait, RoundedCardTrait {
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
        let translatedToday = UserDefaults.standard.integer(forKey: "translatedToday")
        let learnedOverall = UserDefaults.standard.dictionary(forKey: "learned")?.count
        
        var stackViews: [CardPartStackView] = []
        
        let sv = CardPartStackView()
        sv.axis = .vertical
        sv.spacing = 8
        stackViews.append(sv)
            
        let title = CardPartTextView(type: .title)
        title.text = "Number of words translated today:"
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.textAlignment = .center
        sv.addArrangedSubview(title)
        
        let numberTranslatedToday = CardPartTextView(type: .header)
        numberTranslatedToday.text = String(translatedToday)
        numberTranslatedToday.textAlignment = .center
        sv.addArrangedSubview(numberTranslatedToday)
        
        let sv1 = CardPartStackView()
        sv1.axis = .vertical
        sv1.spacing = 8
        stackViews.append(sv1)
        
        let title1 = CardPartTextView(type: .title)
        title1.text = "Number of words learned overall:"
        title1.font = UIFont.boldSystemFont(ofSize: 30)
        title1.textAlignment = .center
        sv1.addArrangedSubview(title1)
        
        let numberLearnedOverall = CardPartTextView(type: .header)
        numberLearnedOverall.text = String(learnedOverall!)
        numberLearnedOverall.textAlignment = .center
        sv1.addArrangedSubview(numberLearnedOverall)
        
        let sv2 = CardPartStackView()
        sv2.axis = .vertical
        sv2.spacing = 8
        stackViews.append(sv2)
        
        let title2 = CardPartTextView(type: .title)
        title2.text = "Your level:"
        title2.font = UIFont.boldSystemFont(ofSize: 30)
        title2.textAlignment = .center
        sv2.addArrangedSubview(title2)
        
        let level = CardPartTextView(type: .header)
        level.text = String(learnedOverall! / 10)
        level.textAlignment = .center
        sv2.addArrangedSubview(level)
        
        let sv3 = CardPartStackView()
        sv3.axis = .vertical
        sv3.spacing = 8
        stackViews.append(sv3)
        
        let title3 = CardPartTextView(type: .header)
        title3.text = "Get unlimited usage of this app at lvl 80."
        sv3.addArrangedSubview(title3)
        
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 200)
        
        setupCardParts([cardPartPagedView])
    }
}

//
//  CardHelpViewController.swift
//  wordBeaver
//
//  Created by Fedor on 27/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts


class CardHelpViewController: CardPartsViewController , ShadowCardTrait, RoundedCardTrait {
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
        
        var stackViews: [CardPartStackView] = []
        
        let sv = CardPartStackView()
        sv.axis = .vertical
        sv.spacing = 8
        stackViews.append(sv)
        
        let title = CardPartTextView(type: .header)
        title.text = "Learn new words easily"
        sv.addArrangedSubview(title)
        
        let sv1 = CardPartStackView()
        sv1.axis = .vertical
        sv1.spacing = 8
        stackViews.append(sv1)
        
        let title1 = CardPartTextView(type: .header)
        title1.text = "Look at the lesson card"
        sv1.addArrangedSubview(title1)
        
        let sv2 = CardPartStackView()
        sv2.axis = .vertical
        sv2.spacing = 8
        stackViews.append(sv2)
        
        let title2 = CardPartTextView(type: .header)
        title2.text = "Remember 11 words"
        sv2.addArrangedSubview(title2)
        
        let sv3 = CardPartStackView()
        sv3.axis = .vertical
        sv3.spacing = 8
        stackViews.append(sv3)
        
        let title3 = CardPartTextView(type: .header)
        title3.text = "Start lesson and check yourself"
        sv3.addArrangedSubview(title3)
        
        let sv4 = CardPartStackView()
        sv4.axis = .vertical
        sv4.spacing = 8
        stackViews.append(sv4)
        
        let title4 = CardPartTextView(type: .header)
        title4.text = "Repeat the words in History Tab"
        sv4.addArrangedSubview(title4)
        
        
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 200)
        
        setupCardParts([cardPartPagedView])
    }
}


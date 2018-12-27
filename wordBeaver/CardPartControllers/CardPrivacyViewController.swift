//
//  CardPrivacyViewController.swift
//  wordBeaver
//
//  Created by Fedor on 27/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts

class CardPrivacyViewController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait  {
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
    let cardPartButtonView = CardPartButtonView()
    let cardPartButton1View = CardPartButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardPartButtonView.setTitle("Write to developer", for: .normal)
        cardPartButtonView.setTitleColor(UIColor.white, for: .normal)
        cardPartButtonView.contentHorizontalAlignment = .center
        cardPartButtonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        cardPartButtonView.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.9, alpha: 1.0)
        cardPartButtonView.layer.cornerRadius = 5
        
        cardPartButton1View.setTitle("Privacy Policy", for: .normal)
        cardPartButton1View.setTitleColor(UIColor.white, for: .normal)
        cardPartButton1View.contentHorizontalAlignment = .center
        cardPartButton1View.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        cardPartButton1View.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.9, alpha: 1.0)
        cardPartButton1View.layer.cornerRadius = 5
        
        setupCardParts([cardPartButtonView, cardPartButton1View])
    }
    
    @objc func buttonTapped() {
        if let url = URL(string: "mailto:ivaccchev@gmail.com") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @objc func button1Tapped() {
        if let url = URL(string: "https://docs.google.com/document/d/1HXCjvA9c6kg8-WBXP2kD5eJyKevtAtcwOG9x8KOZkdQ/edit?usp=sharing") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

class CardVersionViewController: CardPartsViewController, TransparentCardTrait{
    let versionView = CardPartTextView(type: .detail)
    override func viewDidLoad() {
        super.viewDidLoad()
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        versionView.text = "wordBeaver v" + appVersion!
        versionView.textAlignment = .center

        setupCardParts([versionView])
    }
}

//
//  PrivacyPolicyViewController.swift
//  wordBeaver
//
//  Created by Fedor on 27/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts



class PrivacyPolicyViewController: CardsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cards: [CardPartsViewController] = [
            HiddenCardController(),
            CardHelpViewController(),
            CardPrivacyViewController(),
            CardVersionViewController()
        ]
        
        loadCards(cards: cards)
    }
}

//
//  SettingsViewController.swift
//  wordBeaver
//
//  Created by Fedor on 25/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts

class NotificationsViewController: CardsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let cards: [CardPartsViewController] = [
            HiddenCardController(),
            CardPartNotificationController(),
            CardPartNotificationButtonController(),
            CardPartNotificationAddingController(),
            CardPartNotificationAdditionalController()
        ]
        loadCards(cards: cards)
    }
}

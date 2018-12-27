//
//  CardPartNotificationsController.swift
//  wordBeaver
//
//  Created by Fedor on 26/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts
import UserNotifications



class CardPartNotificationController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait  {
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
    let cardPartTextView = CardPartTextView(type: .header)
    

    override func viewDidLoad() {
        cardPartTextView.text = "Enable notifications to study new words without entering the app"
        setupCardParts([cardPartTextView])
    }
}

class CardPartNotificationSliderController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait  {
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
    let cardPartTextView = CardPartTextView(type: .title)
    let switchView = UISwitch()
    
    override func viewDidLoad() {
        
        let notificationCenter1 = NotificationCenter.default
        
        notificationCenter1.addObserver(self, selector: #selector(appMovedFromBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                //let switchState = UserDefaults.standard.bool(forKey: "switchState")
                let switchState = false
                UserDefaults.standard.set(switchState, forKey: "switchState")
            } else {
                let switchState = true
                UserDefaults.standard.set(switchState, forKey: "switchState")
            }
        }
        
        let switchState = UserDefaults.standard.bool(forKey: "switchState")
        if switchState {
            self.switchView.setOn(true, animated: true)
        } else {
            self.switchView.setOn(false, animated: true)
        }
        
        cardPartTextView.textAlignment = .center
        switchView.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        
        
        let sv = CardPartStackView()
        sv.addArrangedSubview(switchView)
        cardPartTextView.text = "Just put the switch to the right side"
        setupCardParts([cardPartTextView, sv])
        
        
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        if value {
            print("Changed to On")
            self.switchView.setOn(true, animated: true)
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        } else {
            self.switchView.setOn(false, animated: true)
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
    }
    
    @objc func appMovedFromBackground() {
        print("App moved from background!")

        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                //let switchState = UserDefaults.standard.bool(forKey: "switchState")
                let switchState = false
                UserDefaults.standard.set(switchState, forKey: "switchState")
            } else {
                let switchState = true
                UserDefaults.standard.set(switchState, forKey: "switchState")
            }
        }
        
        let switchState = UserDefaults.standard.bool(forKey: "switchState")
        if switchState {
            self.switchView.setOn(true, animated: true)
        } else {
            self.switchView.setOn(false, animated: true)
        }
        
    }
}


class CardPartNotificationAddingController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait  {
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
    
    
    override func viewDidLoad() {
        cardPartTextView.text = "4 words from your last lesson will be silently sent to you in an hour after your last visiting the app"
        setupCardParts([cardPartTextView])
    }
}

class CardPartNotificationAdditionalController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait  {
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
    
    
    override func viewDidLoad() {
        cardPartTextView.text = "You can turn off the notifications whenever you want"
        setupCardParts([cardPartTextView])
    }
}


class CardPartNotificationButtonController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait  {
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
    let cardPartButtonView = CardPartButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardPartTextView.text = "Just press the button to go to the settings"
        
        cardPartButtonView.setTitle("Allow Notifications", for: .normal)
        cardPartButtonView.setTitleColor(UIColor.white, for: .normal)
        cardPartButtonView.contentHorizontalAlignment = .center
        cardPartButtonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        cardPartButtonView.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.9, alpha: 1.0)
        cardPartButtonView.layer.cornerRadius = 5
        setupCardParts([cardPartTextView, cardPartButtonView])
    }
    
    @objc func buttonTapped() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
}

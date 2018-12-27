//
//  CardPartButtonViewCardController.swift
//  CardParts_Example
//
//  Created by Roossin, Chase on 5/23/18.
//  Copyright © 2018 Intuit. All rights reserved.
//

import Foundation
import CardParts

class CardPartButtonViewCardController: CardPartsViewController, ShadowCardTrait, RoundedCardTrait {
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
        
        cardPartTextView.text = "A new lesson is waiting for you"
        
        cardPartButtonView.setTitle("Start lesson", for: .normal)
        cardPartButtonView.setTitleColor(UIColor.white, for: .normal)
        cardPartButtonView.contentHorizontalAlignment = .center
        cardPartButtonView.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        cardPartButtonView.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.9, alpha: 1.0)
        cardPartButtonView.layer.cornerRadius = 5
        setupCardParts([cardPartTextView, cardPartButtonView])
    }
    
    @objc func buttonTapped() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView")
        self.present(nextViewController, animated:true, completion:nil)

        let alertController = UIAlertController(title: "Woohoo!", message: "Isn't that awesome!?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

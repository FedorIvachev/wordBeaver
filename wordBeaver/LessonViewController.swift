//
//  LessonViewController.swift
//  wordBeaver
//
//  Created by Fedor on 22/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation

import UIKit

import CardParts

class LessonViewCardController: CardPartsViewController {
    
    let cardPartTextView = CardPartTextView(type: .normal)
    var lessonDictStore = [String: String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
        lessonDictStore = lessonDict! as! [String : String]
        
        
        cardPartTextView.text = "These are new words for you to learn today:"
        
        var stackViews: [CardPartStackView] = []
        
        for _ in 0...10 {
            let word = lessonDict?.first
            
            let sv = CardPartStackView()
            sv.axis = .vertical
            sv.spacing = 8
            stackViews.append(sv)
            
            let title = CardPartTextView(type: .title)
            title.text = (word?.value as! String)
            title.textAlignment = .center
            title.font = UIFont.boldSystemFont(ofSize: 25)
            sv.addArrangedSubview(title)
            
            let separator = CardPartSeparatorView()
            sv.addArrangedSubview(separator)
            
            let translationField = CardPartTextField()
            translationField.placeholder = "Type the translation here"
            translationField.textAlignment = .center
            
            sv.addArrangedSubview(translationField)
            translationField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            lessonDict?.removeValue(forKey: word?.key ?? "Sample")
        }
        
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 200)
        setupCardParts([cardPartTextView, cardPartPagedView])
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (lessonDictStore[textField.text!] != nil) {
            print(lessonDictStore[textField.text!]!)
        }
    }
}


class LessonCardController: CardPartsViewController {
    
}




class LessonViewController: UIViewController {
    
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 11.0
            progressView.setProgress(fractionalProgress, animated: true)
        }
    }
    
    var lessonDictStore = [String: String]()
    var lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
    var wordTranslation = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCard.dropShadow()
        translateButton.roundCorners()
        // Do any additional setup after loading the view, typically from a nib.
        print("Lesson started")
        counter = 0
        let word = lessonDict?.first
        wordLabel.text = (word?.value as! String)
        wordTranslation = word!.key
        
        translationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (lessonDict![textField.text!] != nil) {
            counter += 1
            lessonDict?.removeValue(forKey: textField.text!)
            if counter == 11 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                self.present(newViewController, animated: true, completion: nil)
                
            } else {
                let word = lessonDict?.first
                wordLabel.text = (word?.value as! String)
                wordTranslation = word!.key
                textField.text = ""
            }
            
        }
    }
    
    
    @IBAction func translateButtonPressed(_ sender: Any) {
        translationTextField.text = wordTranslation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // change 2 to desired number of seconds
            self.translationTextField.text = ""
        }
    }
    
    
}

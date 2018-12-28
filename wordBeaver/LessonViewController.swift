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
    
    var lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
    var wordTranslation = ""
    var cheatedDict = [String: String]()
    let notificationCenter = NotificationCenter.default


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
        translationTextField.becomeFirstResponder()
        translationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (lessonDict![textField.text!] != nil) {
            counter += 1
            lessonDict?.removeValue(forKey: textField.text!)
            if counter == 11 {
                addLearnedWords()
                deleteLearnedWords()
                addWordsToCurrentLesson()
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
        cheatedDict[wordTranslation] = wordLabel.text!
        print("Pressed!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // change 2 to desired number of seconds
            self.translationTextField.text = ""
        }
        
    }
    
    func addLearnedWords(){
        var learnedDict = UserDefaults.standard.dictionary(forKey: "learned")
        if (learnedDict == nil){
            learnedDict = UserDefaults.standard.dictionary(forKey: "lesson")
            UserDefaults.standard.set(learnedDict, forKey: "learned")
        } else {
            lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
            let learnedDict1 = learnedDict! + lessonDict!
            UserDefaults.standard.set(learnedDict1, forKey: "learned")
            print(learnedDict1)
        }
        
        var wordsToLearn = ""
        var sessionWords = UserDefaults.standard.dictionary(forKey: "lesson")
        for _ in 1...4{
            let word = sessionWords?.popFirst()
            wordsToLearn = wordsToLearn + word!.key + " - " + (word!.value as! String) + "\n"
        }
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        
        appDelegate?.scheduleNotification(wordsToLearn: wordsToLearn)
        
        
        var translatedToday = UserDefaults.standard.integer(forKey: "translatedToday")
        translatedToday += 11
        UserDefaults.standard.set(translatedToday, forKey: "translatedToday")
    }
    
    func deleteLearnedWords(){
        var mainDict = UserDefaults.standard.dictionary(forKey: "main")
        let lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
        for elem in lessonDict! {
            if (cheatedDict[elem.key] == nil){
                mainDict!.removeValue(forKey: elem.key)
                print(elem.key)
            }
        }
        UserDefaults.standard.set(mainDict, forKey: "main")
        let newLessonDict = [String: String]()
        UserDefaults.standard.set(newLessonDict, forKey: "lesson")
        addWordsToCurrentLesson()
    }
}

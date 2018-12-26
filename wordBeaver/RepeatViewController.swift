//
//  RepearViewController.swift
//  wordBeaver
//
//  Created by Fedor on 23/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation

import UIKit

class RepeatViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var translateButton: UIButton!
    
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 11.0
            progressView.setProgress(fractionalProgress, animated: true)
        }
    }
    
    var learnedDict = UserDefaults.standard.dictionary(forKey: "learned")
    var lessonDict = [String: String]()
    var wordTranslation = ""
    var cheatedDict = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCard.dropShadow()
        translateButton.roundCorners()
        // Do any additional setup after loading the view, typically from a nib.
        print("Lesson Repeat started")
        counter = 0
        var word = learnedDict!.randomElement()
        lessonDict[(word?.key)!] = (word?.value as! String)
        for _ in 0...9{
            word = learnedDict!.randomElement()
            lessonDict[(word?.key)!] = (word?.value as! String)
        }
        
        wordLabel.text = (word?.value as! String)
        wordTranslation = word!.key
        
        translationTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (lessonDict[textField.text!] != nil) {
            counter += 1
            lessonDict.removeValue(forKey: textField.text!)
            if lessonDict.count == 0 {
                deleteLearnedWords()
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
                self.present(newViewController, animated: true, completion: nil)
            } else {
                let word = lessonDict.first
                wordLabel.text = (word?.value)
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
    
    func deleteLearnedWords(){
        var mainDict = UserDefaults.standard.dictionary(forKey: "main")
        for elem in cheatedDict {
            mainDict![elem.key] = elem.value
        }
        UserDefaults.standard.set(mainDict, forKey: "main")
    }
}

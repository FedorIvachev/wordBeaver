//
//  TrainViewController.swift
//  wordBeaver
//
//  Created by Fedor on 22/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation

import UIKit
import CardParts

class TrainViewController: CardsViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addWordsToDictionary()
        addWordsToCurrentLesson()
        addLearnedWords()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let cards: [CardPartsViewController] = [
            CardPartPagedViewCardController(),
            CardPartButtonViewCardController(),
            CardPartTextFieldCardController(),
            CardPartBarViewCardController()
        ]
        
        loadCards(cards: cards)
        
    }
    
    func addWordsToDictionary(){
        let mainDict = UserDefaults.standard.dictionary(forKey: "main")
        if (mainDict == nil) {
            // Need to change this declaration to empty one
            var main = [String: String]()
            
            let Lang1URL = Bundle.main.path(forResource: "wordsFull", ofType: "txt")
            let Lang2URL = Bundle.main.path(forResource: "wordsFullRu", ofType: "txt")
            var readStringLang1 = ""
            var readStringLang2 = ""
            do {
                readStringLang1 = try String(contentsOfFile: Lang1URL!, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Failed reading from URL: \(Lang1URL ?? ""), Error: " + error.localizedDescription)
            }
            do {
                readStringLang2 = try String(contentsOfFile: Lang2URL!, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Failed reading from URL: \(Lang2URL ?? ""), Error: " + error.localizedDescription)
            }
            let lang1Array = readStringLang1.components(separatedBy: ["\n"])
            let lang2Array = readStringLang2.components(separatedBy: ["\n"])
            for i in 0...(lang1Array.count - 2){
                main[lang1Array[i]] = lang2Array[i]
            }
            UserDefaults.standard.set(main, forKey: "main")
        } else {
            print("Set already!")
        }
    }
    
    func addWordsToCurrentLesson(){
        let mainDict = UserDefaults.standard.dictionary(forKey: "main") // not empty
        let lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
        if lessonDict == nil{
            var lesson = [String: String]()
            for _ in 0...10{
                let word = mainDict?.randomElement()
                print(word?.key ?? "Sample")
                print(word?.value ?? "Sample")
                lesson[word?.key ?? "Sample"] = word?.value as? String
            }
            UserDefaults.standard.set(lesson, forKey: "lesson")
        } else {
            print("Set already!")
        }
    }
    
    func addLearnedWords(){
        let score = UserDefaults.standard.integer(forKey: "score")
        if (score == 0) {
            UserDefaults.standard.set(0, forKey: "score")
        }
    }
    
    
    
}


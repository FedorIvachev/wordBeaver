//
//  Extensions.swift
//  wordBeaver
//
//  Created by Fedor on 22/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts

extension UIView {
    
    func dropShadow() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
}

extension UIButton {
    func roundCorners() {
        self.layer.cornerRadius = 5
    }
}


func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    rhs.forEach{ result[$0] = $1 }
    return result
}

func addWordsToCurrentLesson(){
    let mainDict = UserDefaults.standard.dictionary(forKey: "main") // not empty
    let lessonDict = UserDefaults.standard.dictionary(forKey: "lesson")
    if (lessonDict == nil || lessonDict!.count == 0) {
        var lesson = [String: String]()
        while lesson.count != 11 {
            let word = mainDict?.randomElement()
            lesson[word?.key ?? "Sample"] = word?.value as? String
        }
        UserDefaults.standard.set(lesson, forKey: "lesson")
    } else {
        print("Set already!")
    }
}

class HiddenCardController: CardPartsViewController, TransparentCardTrait{
    override func viewDidLoad() {
        let separator = CardPartSpacerView(height: 0)
        setupCardParts([separator])
    }
}

func changeLanguages(native: String, desired: String){
    print("here")
    var main = [String: String]()
    var nativeFileName = ""
    var desiredFileName = ""
    switch ( native, desired )
    {
    case ("Russian", "English")  :
        nativeFileName = "wordsFullRu"
        desiredFileName = "wordsFull"
    case ("English", "Russian")  :
        nativeFileName = "wordsFull"
        desiredFileName = "wordsFullRu"
    case ("Chinese", "English"):
        nativeFileName = "wordsFullChEn"
        desiredFileName = "wordsFull"
    case ("English", "Chinese") :
        nativeFileName = "wordsFull"
        desiredFileName = "wordsFullChEn"
    case ("Russian", "Chinese") :
        nativeFileName = "wordsFullRu"
        desiredFileName = "wordsFullChRu"
    case ("Chinese", "Russian") :
        nativeFileName = "wordsFullChRu"
        desiredFileName = "wordsFullRu"
    default:
        nativeFileName = "wordsFullRu"
        desiredFileName = "wordsFull"
    }
    let Lang1URL = Bundle.main.path(forResource: desiredFileName, ofType: "txt")
    let Lang2URL = Bundle.main.path(forResource: nativeFileName, ofType: "txt")
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
}

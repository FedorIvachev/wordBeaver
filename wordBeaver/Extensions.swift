//
//  Extensions.swift
//  wordBeaver
//
//  Created by Fedor on 22/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit

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
        for _ in 0...10{
            let word = mainDict?.randomElement()
            lesson[word?.key ?? "Sample"] = word?.value as? String
        }
        UserDefaults.standard.set(lesson, forKey: "lesson")
    } else {
        print("Set already!")
    }
}

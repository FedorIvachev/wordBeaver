//
//  LanguageViewController.swift
//  wordBeaver
//
//  Created by Fedor on 27/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit

class LanguageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0){
            return "\(nativePickerData[row])"
        } else {
            return "\(desiredPickerData[row])"
        }
    }
    
    @IBOutlet weak var nativePicker: UIPickerView!
    
    @IBOutlet weak var desiredPicker: UIPickerView!
    
    @IBAction func applyButton(_ sender: Any) {
        let nativeLang = nativePickerData[nativePicker.selectedRow(inComponent: 0)]
        let desiredLang = desiredPickerData[desiredPicker.selectedRow(inComponent: 0)]
        if (nativeLang == desiredLang) {
            let alertController = UIAlertController(title: "Wrong language", message: "Please select different languages", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            UserDefaults.standard.set(nativeLang, forKey: "native")
            UserDefaults.standard.set(desiredLang, forKey: "desired")
            changeLanguages(native: nativeLang, desired: desiredLang)
            let lesson = [String: String]()
            UserDefaults.standard.set(lesson, forKey: "lesson")
            addWordsToCurrentLesson()
            let learned = [String: String]()
            UserDefaults.standard.set(learned, forKey: "learned")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var applyButtonOutlet: UIButton!
    
    var nativePickerData: [String] = [String]()
    var desiredPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nativePickerData = ["English", "Russian", "Chinese"]
        desiredPickerData = ["English", "Russian", "Chinese"]
        applyButtonOutlet.roundCorners()
        
    }
}

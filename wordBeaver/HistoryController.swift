//
//  HistoryController.swift
//  wordBeaver
//
//  Created by Fedor on 22/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var learnedTable: UITableView!
    
    @IBOutlet weak var repeatButton: UIBarButtonItem!
    var learned = UserDefaults.standard.dictionary(forKey: "learned")
    var indices: [String] = []
    var arr : [(String, String)] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //learned = UserDefaults.standard.dictionary(forKey: "learned")
        for (key, value) in learned! {
            arr.append((key, value as! String))
        }
        arr = arr.sorted(by: { $0.0 < $1.0 })
        indices = learned!.keys.sorted()
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indices.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        //cell.profile = arr[indices[indexPath.row]]!
        cell.textLabel!.text = arr[indexPath.row].0 + " - " + arr[indexPath.row].1
        return cell
    }
}

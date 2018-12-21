//
//  TrainViewController.swift
//  wordBeaver
//
//  Created by Fedor on 22/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation

import UIKit

class TrainViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width:20, height:20)
            )
        )
        view1.backgroundColor = .red
        stackView.addArrangedSubview(view1)

        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
}

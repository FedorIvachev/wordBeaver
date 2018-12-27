//
//  CardPartBarViewController.swift
//  wordBeaver
//
//  Created by Fedor on 26/12/2018.
//  Copyright © 2018 rodiv. All rights reserved.
//

import Foundation
import UIKit
import CardParts
import Charts


class BarChartController : CardPartsViewController, ShadowCardTrait, RoundedCardTrait {
    func shadowColor() -> CGColor {
        return UIColor.lightGray.cgColor
    }
    
    func shadowRadius() -> CGFloat {
        return 10.0
    }
    
    func shadowOpacity() -> Float {
        return 0.5
    }
    
    func cornerRadius() -> CGFloat {
        return 10.0
    }
    let cardPartTextView = CardPartTextView(type: .normal)
    override func viewDidLoad() {
        super.viewDidLoad()
        var stackViews: [CardPartStackView] = []
        let sv = CardPartStackView()
        sv.axis = .vertical
        sv.spacing = 8
        stackViews.append(sv)
        let barView = BarChartView()
        sv.addArrangedSubview(barView)
        let cardPartPagedView = CardPartPagedView(withPages: stackViews, andHeight: 200)
        setupCardParts([cardPartTextView, cardPartPagedView])
    }
}

/*
protocol GetChartData {
    func getChartData(with dataPoints: [String], values: [String])
    var workoutDuration : [String] {get set}
    var beatsPerMinute : [String] {get set}
}

class ChartsViewController: UIViewController, GetChartData {
    var workoutDuration = [String]()
    var beatsPerMinute = [String]()
    override func viewDidLoad() {
        populateChartData()
        cubicChart()
    }
    func populateChartData() {
        workoutDuration = ["1”,”2","3","4","5","6"]
        beatsPerMinute = ["99”,”100","120","155","162","190"]
    }
    func cubicChart() {
        let cubicChart = CubicChart(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:self.view.frame.height))
        cubicChart.delegate = self
        self.view.addSubview(cubicChart)
    }
    func getChartData(with dataPoints: [String], values: [String]) {
        self.workoutDuration = dataPoints
        self.beatsPerMinute = values
    }
}
*/

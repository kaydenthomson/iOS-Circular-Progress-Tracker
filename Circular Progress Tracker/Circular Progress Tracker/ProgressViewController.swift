//
//  ProgressViewController.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/23/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    private let minutesInHour: Int = 60
    private let minutesInDay: Int = 1440
    var countingDown: Bool = true
    
    var completion: Float {
        if (countingDown) {
            return Float(minutesInDay - minutesOfDay()) / Float(minutesInDay)
        }
        return Float(minutesOfDay()) / Float(minutesInDay)
    }
    
    @IBOutlet weak var progressLabel: UILabel!{
        didSet {
            let text: String = String(format: "%.0f", completion * 100)
            let decimalText: String = String(format: "%.1f", completion * 100)
            
            if (text + ".0" == decimalText) {
                progressLabel.text = text + "%"
            } else {
                progressLabel.text = decimalText + "%"
            }
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBOutlet weak var progressCircleView: ProgressCircleView! {
        didSet {
            progressCircleView.completion = CGFloat(self.completion)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func minutesOfDay() -> Int {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let minutesOfDay = hour * minutesInHour + minutes
        
        return minutesOfDay
    }
}

extension UIColor {
    static var greenBlue: UIColor  { return UIColor(red: 1, green: 0, blue: 0, alpha: 1) }
    static var grayBlue: UIColor { return UIColor(red: 0, green: 1, blue: 0, alpha: 1) }
}


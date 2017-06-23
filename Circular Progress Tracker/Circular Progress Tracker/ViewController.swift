//
//  ViewController.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/23/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var completion: Double = 0.834
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
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
    
    @IBOutlet weak var progressCircleView: ProgressCircleView! {
        didSet {
            progressCircleView.completion = CGFloat(self.completion)
        }
    }
}


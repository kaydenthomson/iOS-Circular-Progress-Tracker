//
//  WhiteTimePicker.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 8/1/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class WhiteTimePicker: UIDatePicker {
    let colorTheme = ColorTheme.Blue
    
    override func draw(_ rect: CGRect) {
        self.setValue(UIColor.white, forKey: "textColor")
        self.datePickerMode = .time
        self.backgroundColor = colorTheme.Background
    }
}

//
//  WhiteTimePicker.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 8/1/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class WhiteTimePicker: UIDatePicker {
    var changed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setValue(UIColor.white, forKey: "textColor")
        self.datePickerMode = .time
    }
}

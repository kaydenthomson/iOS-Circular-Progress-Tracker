//
//  TimePickerTableViewCell.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 8/2/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

protocol TimePickerTableViewCellDelegate: class {
    func timeChangedForField(indexPath: IndexPath, toTime: Date)
}

class TimePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var timePicker: WhiteTimePicker!
    var delegate: TimePickerTableViewCellDelegate?
    var indexPath: IndexPath = []
    
    func configure(indexPath: IndexPath, currentDate: Date?, delegate: TimePickerTableViewCellDelegate) {
        self.timePicker.setDate(currentDate ?? Date(), animated: true)
        self.delegate = delegate
        self.indexPath = indexPath
    }
    
    @IBAction func timeValueChanged(_ sender: WhiteTimePicker) {
        delegate?.timeChangedForField(indexPath: self.indexPath, toTime: self.timePicker.date)
    }
}

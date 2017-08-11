//
//  ColorSettingTableViewCell.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 8/4/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

protocol ColorTableViewCellDelegate {
    func selectColor(colorCell: ColorSettingTableViewCell, theme: ColorTheme)
}

class ColorSettingTableViewCell: UITableViewCell {
    
    var delegate: ColorTableViewCellDelegate?
    var theme: ColorTheme = .Blue {
        didSet {
            textLabel?.textColor = theme.Primary
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            accessoryType = .checkmark
            delegate?.selectColor(colorCell: self, theme: theme)
        } else {
            accessoryType = .none
        }
    }
    
}

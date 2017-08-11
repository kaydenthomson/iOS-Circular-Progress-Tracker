//
//  SettingNavigationController.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 8/4/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class SettingNavigationController: UINavigationController {
    
    var theme: ColorTheme = .Blue {
        didSet {
            self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.Primary]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: theme.Primary]
    }

}

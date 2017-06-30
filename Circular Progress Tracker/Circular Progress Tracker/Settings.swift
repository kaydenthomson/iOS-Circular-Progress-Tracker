//
//  Settings.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/29/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import Foundation
import UIKit

public enum ColorTheme {
    case Green
    case Pink
    case Red
    case Blue
    
    var Primary: UIColor {
        switch self {
        case .Green:
            return ColorPalette.Primary.Green
        case .Pink:
            return ColorPalette.Primary.Pink
        case .Red:
            return ColorPalette.Primary.Red
        case .Blue:
            return ColorPalette.Primary.Blue
        }
    }
    
    var Secondary: UIColor {
        switch self {
        case .Green, .Blue:
            return ColorPalette.Secondary.DarkGreenBlue
        case .Pink:
            return ColorPalette.Secondary.DarkGreenBlue
        case .Red:
            return ColorPalette.Secondary.DarkGreenBlue
        }
    }
    
    var Background: UIColor {
        switch self {
        case .Green, .Blue:
            return ColorPalette.Background.DeepDark
        case .Pink:
            return ColorPalette.Background.DeepDark
        case .Red:
            return ColorPalette.Background.DeepDark
        }
    }
}

// MARK: Immutable colors
public enum ColorPalette {
    
    fileprivate enum Neutral {
        static let Black =           #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // "#000000"
        static let DarkGray1 =       #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1) // "#181818"
        static let DarkGray2 =       #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1) // "#222222"
        static let MediumGray1 =     #colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2117647059, alpha: 1) // "#363636"
        static let MediumGray2 =     #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1) // "#555555"
        static let LightGray1 =      #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1) // "#AAAAAA"
        static let LightGray2 =      #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // "#CCCCCC"
        static let White =           #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // "#FFFFFF"
    }
    
    fileprivate enum Primary {
        static let Green =           #colorLiteral(red: 0.08809600025, green: 0.831815064, blue: 0.664421618, alpha: 1) // "#21CE99"
        static let Red =             #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1) // "#FF141C"
        static let Blue =            #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.9176470588, alpha: 1) // "#3498EA"
        static let Orange =          #colorLiteral(red: 0.9450980392, green: 0.3568627451, blue: 0.1647058824, alpha: 1) // "#F15B2A"
        static let Pink =            #colorLiteral(red: 0.9254901961, green: 0, blue: 0.5490196078, alpha: 1) // "#EC008C"
    }
    
    fileprivate enum Secondary {
        static let DarkGreenBlue =   #colorLiteral(red: 0.09019607843, green: 0.1490196078, blue: 0.2039215686, alpha: 1) // "#172634"
    }
    
    fileprivate enum Background {
        static let DeepDark =        #colorLiteral(red: 0.007843137255, green: 0.02745098039, blue: 0.09803921569, alpha: 1) // "#121C28"
    }
}

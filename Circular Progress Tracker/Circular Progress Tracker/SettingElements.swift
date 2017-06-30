//
//  SettingElements.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/29/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import Foundation
import UIKit


// MARK: Immutable colors
public enum ColorPalette {
    
    fileprivate enum Neutral {
        
        static let A =               #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // "#000000"
        static let B =               #colorLiteral(red: 0.09411764706, green: 0.09411764706, blue: 0.09411764706, alpha: 1) // "#181818"
        static let C =               #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1) // "#222222"
        static let D =               #colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2117647059, alpha: 1) // "#363636"
        static let E =               #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1) // "#555555"
        static let X =               #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1) // "#AAAAAA"
        static let Y =               #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // "#CCCCCC"
        static let Z =               #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // "#FFFFFF"
        
    }
    
    fileprivate enum Primary {
        
        static let Orange =          #colorLiteral(red: 0.9450980392, green: 0.3568627451, blue: 0.1647058824, alpha: 1) // "#F15B2A"
        static let Pink =            #colorLiteral(red: 0.9254901961, green: 0, blue: 0.5490196078, alpha: 1) // "#EC008C"
        
    }
    
    fileprivate enum Secondary {
        
        static let YellowGreen =     #colorLiteral(red: 0.6078431373, green: 0.7843137255, blue: 0.3137254902, alpha: 1) // "#9BC850"
        static let Green =           #colorLiteral(red: 0.2078431373, green: 0.7098039216, blue: 0.3450980392, alpha: 1) // "#35B558"
        static let Red =             #colorLiteral(red: 0.8705882353, green: 0.2117647059, blue: 0.2117647059, alpha: 1) // "#DE3636"
        static let Yellow =          #colorLiteral(red: 0.968627451, green: 0.7176470588, blue: 0.1215686275, alpha: 1) // "#F7B71F"
        static let AquaMarine =      #colorLiteral(red: 0.1647058824, green: 0.6235294118, blue: 0.737254902, alpha: 1) // "#2A9FBC"
        static let Yellow3 =         #colorLiteral(red: 0.6784313725, green: 0.5058823529, blue: 0.1764705882, alpha: 1) // "#AD812D"
        static let Blue =            #colorLiteral(red: 0.07058823529, green: 0.4980392157, blue: 0.7882352941, alpha: 1) // "#127FC9"
        
    }
    
}



// MARK: - Theme colors
public extension ColorPalette {
    
    fileprivate static let IBSeparator = "."
    fileprivate static let IBAlphaSeparator = "#"
    
    // MARK: Status
    public enum Status {
        public static let Success = Secondary.Green
        public static let Error = Secondary.Red
        public static let Warning = Secondary.Yellow
        public static let Alert = Secondary.Blue
    }
    
    // MARK: Assessment
    public enum Assessment {
        public static let A = Secondary.Yellow
        public static let B = Secondary.YellowGreen
        public static let C = Secondary.AquaMarine
    }
    
    // MARK: Rating
    public enum Rating {
        public static let Rating = Secondary.Yellow3
        public static let UserRating = Primary.Orange
    }
    
    // MARK: TextColor
    public enum TextColor {
        public static let Primary = Neutral.Z
        public static let Secondary = Neutral.X
        public static let Tertiary = Neutral.C
        public static let Quarternary = Neutral.E
        public static let Interactive = ColorPalette.Primary.Orange
        public static let DarkPlaceholder = Neutral.D
        public static let Destructive = ColorPalette.Secondary.Red
    }
    
    // MARK: BackgroundColor
    public enum BackgroundColor {
        public static let Primary = Neutral.B
        public static let Secondary = Neutral.C
        public static let Tertiary = Neutral.D
        public static let Quaternary = Neutral.E
        public static let Quinary = Neutral.Y
        public static let Highlight = ColorPalette.Primary.Orange
        public static let Black = Neutral.A
        public static let White = Neutral.Z
    }
    
    // MARK: Separator
    public enum Separator {
        public static let Primary = Neutral.B
        public static let Secondary = Neutral.C
    }
    
    // MARK: Tint
    public enum Tint {
        public static let Primary = ColorPalette.Primary.Orange
        public static let Secondary = Neutral.X
        public static let Tertiary = Neutral.Z
        public static let Quarternary = Neutral.C
    }
}









// MARK: - Private helpers
public extension ColorPalette {
    internal static func IBColorFromString(_ string: String) -> UIColor? {
        guard string.characters.count > 0 else {
            return nil
        }
        
        return colorFromString(string)
    }
    
    public static func colorFromString(_ string: String) -> UIColor {
        let alphaComponents = string.lowercased().components(separatedBy: IBAlphaSeparator)
        
        guard alphaComponents.count > 0 && alphaComponents.count <= 2 else {
            fatalError("Invalid string")
        }
        
        let alpha: CGFloat
        
        if alphaComponents.count == 2 {
            guard let alphaPercentage = Float(alphaComponents[1]) else {
                fatalError("Not a valid number")
            }
            
            alpha = CGFloat(max(min(alphaPercentage, 100), 0) / 100.0)
        } else {
            alpha = 1.0
        }
        
        let components = alphaComponents[0].lowercased().components(separatedBy: IBSeparator)
        
        guard let first = components.first else {
            fatalError("Invalid string")
        }
        
        let color: UIColor
        
        switch first {
        case "status":
            color = Status.colorFromString(components.second)
        case "assessment":
            color = Assessment.colorFromString(components.second)
        case "textcolor":
            color = TextColor.colorFromString(components.second)
        case "backgroundcolor":
            color = BackgroundColor.colorFromString(components.second)
        case "separator":
            color = Separator.colorFromString(components.second)
        case "rating":
            color = Rating.colorFromString(components.second)
        case "tint":
            color = Tint.colorFromString(components.second)
        default:
            fatalError("Invalid string: \(string)")
        }
        
        if alpha == 1.0 {
            return color
        } else {
            return color.withAlphaComponent(alpha)
        }
    }
}

private extension ColorPalette.Status {
    static func colorFromString(_ string: String?) -> UIColor {
        guard let string = string else {
            fatalError("Invalid string")
        }
        
        switch string {
        case "success":
            return Success
        case "error":
            return Error
        case "warning":
            return Warning
        case "alert":
            return Alert
        default:
            fatalError("Invalid string: \(string)")
        }
    }
}

private extension ColorPalette.Assessment {
    static func colorFromString(_ string: String?) -> UIColor {
        guard let string = string else {
            fatalError("Invalid string")
        }
        
        switch string {
        case "a":
            return A
        case "b":
            return B
        case "c":
            return C
        default:
            fatalError("Invalid string: \(string)")
        }
    }
}

private extension ColorPalette.TextColor {
    static func colorFromString(_ string: String?) -> UIColor {
        guard let string = string else {
            fatalError("Invalid string")
        }
        
        switch string {
        case "primary":
            return Primary
        case "secondary":
            return Secondary
        case "tertiary":
            return Tertiary
        case "quarternary":
            return Quarternary
        case "interactive":
            return Interactive
        case "darkplaceholder":
            return DarkPlaceholder
        case "destructive":
            return Destructive
        default:
            fatalError("Invalid string: \(string)")
        }
    }
}

private extension ColorPalette.BackgroundColor {
    static func colorFromString(_ string: String?) -> UIColor {
        guard let string = string else {
            fatalError("Invalid string")
        }
        
        switch string {
        case "primary":
            return Primary
        case "secondary":
            return Secondary
        case "tertiary":
            return Tertiary
        case "quaternary":
            return Quaternary
        case "quinary":
            return Quinary
        case "highlight":
            return Highlight
        case "black":
            return Black
        case "white":
            return White
        default:
            fatalError("Invalid string: \(string)")
        }
    }
}

private extension ColorPalette.Separator {
    static func colorFromString(_ string: String?) -> UIColor {
        guard let string = string else {
            fatalError("Invalid string")
        }
        
        switch string {
        case "primary":
            return Primary
        case "secondary":
            return Secondary
        default:
            fatalError("Invalid string: \(string)")
        }
    }
}

private extension ColorPalette.Rating {
    static func colorFromString(_ string: String?) -> UIColor {
        guard let string = string else {
            fatalError("Invalid string")
        }
        
        switch string {
        case "rating":
            return Rating
        case "userrating":
            return UserRating
        default:
            fatalError("Invalid string: \(string)")
        }
    }
}

private extension ColorPalette.Tint {
    static func colorFromString(_ string: String?) -> UIColor {
        guard let string = string else {
            fatalError("Invalid string")
        }
        
        switch string {
        case "primary":
            return Primary
        case "secondary":
            return Secondary
        case "tertiary":
            return Tertiary
        case "quarternary":
            return Quarternary
        default:
            fatalError("Invalid string: \(string)")
        }
    }
}


extension Collection {
    
    public var second: Self.Iterator.Element? {
        guard count > 1 else {
            return nil
        }
        
        return self[index(startIndex, offsetBy: 1)]
        //        return self[index.index(startIndex, offsetBy: 1)]
    }
    
}

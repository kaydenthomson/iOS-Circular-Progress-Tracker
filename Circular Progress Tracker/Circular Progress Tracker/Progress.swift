//
//  Progress.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 8/4/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

class Progress {
    private let minutesInHour: Int = 60
    private let minutesInDay: Int = 1440
    var countingDown: Bool = true
    var colorTheme: ColorTheme = .Blue
    var wakeTime: Date
    var sleepTime: Date
    
    var completion: Float {
        if countingDown {
            let totalDayTime = minutesOfDay(time: sleepTime) - minutesOfDay(time: wakeTime)
            return Float(totalDayTime - minutesOfDay()) / Float(totalDayTime)
        }
        return Float(minutesOfDay()) / Float(minutesInDay)
    }
    
    init?(wakeTime: Date, sleepTime: Date, countingDown: Bool, colorTheme: ColorTheme) {
        self.countingDown = countingDown
        self.colorTheme = colorTheme
        self.wakeTime = wakeTime
        self.sleepTime = sleepTime
    }
    
    private func minutesOfDay(time: Date? = Date()) -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time!)
        let minutes = calendar.component(.minute, from: time!)
        let minutesOfDay = hour * minutesInHour + minutes
        
        return minutesOfDay
    }
}

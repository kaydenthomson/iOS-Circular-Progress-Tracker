//
//  ProgressCircleView.swift
//  Circular Progress Tracker
//
//  Created by Kayden Thomson on 6/23/17.
//  Copyright © 2017 Kayden Thomson. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressCircleView: UIView {
    
    @IBInspectable
    var scale: CGFloat = 0.9
    
    @IBInspectable
    var circleWidth: CGFloat = 20
    
    @IBInspectable
    var containerCircleColor: UIColor = UIColor.darkGray
    
    private var circleRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private var circleCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private func pathForCircle(startAngle start: CGFloat, endAngle end: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: start, endAngle: end, clockwise: true)
        path.lineWidth = circleWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        containerCircleColor.set()
        pathForCircle(startAngle: 0, endAngle: 2*CGFloat.pi).stroke()
    }
}

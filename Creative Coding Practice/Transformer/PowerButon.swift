//
//  CircleProgressView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/04/16.
//

import UIKit

class PowerButton: UIButton {
    var trackBorderWidth: CGFloat = 10
    var backgroundPercent: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var bezierPercent: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var isReverse:Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    static let startDegrees: CGFloat = 320
    static let endDegrees: CGFloat = 220
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()!

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let backgroundColors = [
            UIColor(displayP3Red: (75-75*backgroundPercent)/255, green: (75-75*backgroundPercent)/255, blue: (75-75*backgroundPercent)/255, alpha: 1).cgColor,
            UIColor(red: (55-55*backgroundPercent)/255, green: (55-55*backgroundPercent)/255, blue: (55-55*backgroundPercent)/255, alpha:1).cgColor]

        let gradient = CGGradient(colorsSpace: colorSpace,
                                       colors: backgroundColors as CFArray,
                                    locations: colorLocations)!

        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                            start: startPoint,
                              end: endPoint,
                          options: [CGGradientDrawingOptions(rawValue: 0)])
        
        let startAngle: CGFloat = radians(of: PowerButton.startDegrees)
        let progressAngle = radians(of: PowerButton.startDegrees + (360 - PowerButton.startDegrees + PowerButton.endDegrees) * CGFloat(max(0.0, min(bezierPercent, 1.0))))
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(center.x, center.y) - trackBorderWidth / 2 - 20
        
        let arcPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: radians(of: PowerButton.startDegrees + (360 - PowerButton.startDegrees + PowerButton.endDegrees)), clockwise: true)
        arcPath.lineWidth = trackBorderWidth
        arcPath.lineCapStyle = .round
        
        if !isReverse {
        UIColor(red: 34/255, green: 34/255, blue: 211/255, alpha: 1).set()
        }else{
            UIColor.black.set()
        }
        arcPath.stroke()
        
        let arcPath2 = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: progressAngle, clockwise: true)
        
        let bezierColors = [
            UIColor.white.cgColor,
            UIColor(displayP3Red: 242/255, green: 210/255, blue: 34/255, alpha: 255/255).cgColor, UIColor(displayP3Red: 245/255, green: 241/255, blue: 80/255, alpha: 255/255).cgColor]
        
        let gradientColor = CGGradient(colorsSpace: nil, colors: bezierColors as CFArray, locations: nil)!
        
        let arcCtx = UIGraphicsGetCurrentContext()!
        arcCtx.setLineWidth(10)
        arcCtx.setLineCap(.round)
        arcCtx.saveGState()
        arcCtx.addPath(arcPath2.cgPath)
        arcCtx.replacePathWithStrokedPath()
        arcCtx.clip()
        arcCtx.drawLinearGradient(gradientColor, start: CGPoint(x: 0, y: 0), end: CGPoint(x: frame.width, y: 0), options: [])
        arcCtx.restoreGState()
        
        let straightPath = UIBezierPath()
        straightPath.move(to: CGPoint(x: center.x, y: 20))
        straightPath.addLine(to: CGPoint(x: center.x, y:40))
        straightPath.lineWidth = trackBorderWidth
        straightPath.lineCapStyle = .round
        
        if !isReverse {
        UIColor(red: 34/255, green: 34/255, blue: 211/255, alpha: 1).set()
        }else{
            UIColor.black.set()
        }
        
        straightPath.stroke()
        
        let straightPath2 = UIBezierPath()
        straightPath2.move(to: CGPoint(x: center.x, y: 20))
        if bezierPercent > 0 {
        straightPath2.addLine(to: CGPoint(x: center.x, y:20 + 20 * bezierPercent))
        }
        
        let straightCtx = UIGraphicsGetCurrentContext()!
        straightCtx.setLineWidth(10)
        straightCtx.setLineCap(.round)
        straightCtx.saveGState()
        straightCtx.addPath(straightPath2.cgPath)
        straightCtx.replacePathWithStrokedPath()
        straightCtx.clip()
        straightCtx.drawLinearGradient(gradientColor, start: CGPoint(x: 0, y: 0), end: CGPoint(x: frame.width, y: 0), options: [])
        straightCtx.restoreGState()
    }
    
    private func radians(of degrees: CGFloat) -> CGFloat {
        return degrees / 180 * .pi
    }
}

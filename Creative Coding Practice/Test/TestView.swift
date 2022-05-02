//
//  BezierView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/20.
//

import UIKit

class TestView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path:UIBezierPath = UIBezierPath(ovalIn: CGRect(x: bounds.midX-50, y:bounds.midY-50, width: 100, height: 200))
        
        let gradientColors:[CGColor] = [UIColor.red.cgColor,UIColor.blue.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
    
        let colorLocations: [CGFloat] = [0.0,1.0]
        
        let cgGradientColor = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations:colorLocations)!
        
        let context = UIGraphicsGetCurrentContext()!
        context.addPath(path.cgPath)
        context.setLineWidth(10)
        context.clip()
        context.replacePathWithStrokedPath()
        context.drawLinearGradient(cgGradientColor, start: CGPoint(x: 0, y: 0), end: CGPoint(x: frame.width, y:frame.height), options: [])
    }
}

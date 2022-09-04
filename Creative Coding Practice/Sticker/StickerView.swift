//
//  StickerBack.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/08/28.
//

import UIKit
import EasierPath

class StickerView: UIView {
    
    var w: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var h: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
//        backgroundColor = w > 200 ? .white : .black
        
        
//        let down = w <= 200 ? 0 : min(50,w - 200)
//
//        let easierPath = EasierPath(bounds.midX + 100, bounds.midY - 50 + down)
//            .left(min(w,250))
//            .down(min(h,200))
//            .right(h <= 100 ? w : min(w,100))
//            .up(min(h,200))
//
//        let redLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .red)
//
//        let easierPath2 = EasierPath(bounds.midX  + 100,bounds.midY - 50)
//            .left(w <= 200 ? w :200 - (w - 200))
//            .rightDown(w <= 200 ? w :200 - (w - 200), h)
//            .up(h)
//
//        let whiteLayer = easierPath2.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .white)
//
//          let gradientColors:[CGColor] = [UIColor.red.cgColor,UIColor.blue.cgColor]
//
//          let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//          let colorLocations: [CGFloat] = [0.0,1.0]
//
//          let cgGradientColor = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations:colorLocations)!
//
//          let context = UIGraphicsGetCurrentContext()!
//          context.addPath(easierPath.path.cgPath)
//          context.setLineWidth(1)
//          context.clip()
//          context.replacePathWithStrokedPath()
//          context.drawLinearGradient(cgGradientColor, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 300, y:200), options: [])
      }
    
    func setDefaultView() {
        let defaultView = EasierPath(bounds.midX + 100, bounds.midY - 50)
            .left(200)
            .down(100)
            .right(200)
            .up(100)
        let defaultLayer = defaultView
    }
}

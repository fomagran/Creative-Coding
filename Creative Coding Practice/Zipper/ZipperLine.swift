//
//  ZipperLine.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/05/07.
//

import UIKit

class ZipperLine:UIView {
    var h:CGFloat = 0
    var w:CGFloat = 0
    var current: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        h = rect.height/20
        w = rect.width/2
        var y:CGFloat = 0
        
        for i in 0..<20 {
            let line = i%2 == 0 ? creatLeftLine(0, y) : creatRightLine(rect.maxX, y)
            let angle:CGFloat = i%2 == 0 ? 15 : -15
            UIColor.white.setFill()
            UIColor.clear.setStroke()
            line.rotateAroundCenter(angle:angle)
            line.fill()
            line.stroke()
            line.close()
            y += h+10
        }
    }
    
    func creatLeftLine(_ x:CGFloat,_ y:CGFloat) -> UIBezierPath {
        let lineDot:UIBezierPath = UIBezierPath()
        lineDot.move(to: CGPoint(x: x,y:y))
        lineDot.addLine(to: CGPoint(x:x,y: y+h))
        lineDot.addLine(to: CGPoint(x:x+w,y:y+h))
        lineDot.addQuadCurve(to: CGPoint(x:x+w,y:y), controlPoint: CGPoint(x:w*1.2,y:y+h/2))
        lineDot.addLine(to: CGPoint(x:x,y:y))
        return lineDot
    }
    
    func creatRightLine(_ x:CGFloat,_ y:CGFloat) -> UIBezierPath {
        let lineDot:UIBezierPath = UIBezierPath()
        lineDot.move(to: CGPoint(x: x,y:y))
        lineDot.addLine(to: CGPoint(x:x-w,y:y))
        lineDot.addQuadCurve(to: CGPoint(x:x-w,y:y+h), controlPoint: CGPoint(x:x-w*1.2,y:y+h/2))
        lineDot.addLine(to: CGPoint(x:x,y: y+h))
        lineDot.addLine(to: CGPoint(x:x,y:y))
        return lineDot
    }
}

extension UIBezierPath
{
    func rotateAroundCenter(angle: CGFloat)
    {
        let center = CGPoint(x: bounds.minX+bounds.size.width/2, y: bounds.minY+bounds.size.height/2)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: angle)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        self.apply(transform)
    }
}

//
//  BezierView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/20.
//

import UIKit

class BezierView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: center)
        path.addLine(to: CGPoint(x:center.x + 100, y: center.y))
        path.addCurve(to: CGPoint(x:center.x + 100, y: center.y+100),
                      controlPoint1: CGPoint(x:center.x + 50, y: center.y+25),
                      controlPoint2: CGPoint(x:center.x + 150, y: center.y+75))
        path.addQuadCurve(to: CGPoint(x:center.x, y: center.y+100),
                          controlPoint: CGPoint(x:center.x + 50, y: center.y+50))
        UIColor.systemYellow.setStroke()
        path.lineWidth = 10
//        path.setLineDash([10,1,5,2], count: 4, phase: 10)
        path.stroke()
        UIColor.systemBlue.setFill()
        path.fill(with: CGBlendMode.darken, alpha: 0.5)
    }
}

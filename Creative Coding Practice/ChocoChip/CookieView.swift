//
//  CookieView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/13.
//

import UIKit

class CookieView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor(red: 123/255.0, green: 63/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        shapeLayer.path = bezierPath()
        layer.addSublayer(shapeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bezierPath() -> CGPath {
        let startAngle = CGFloat.pi/180 * 315
        let endAngle = startAngle - .pi/2
        let r = frame.width/2
        let path = UIBezierPath()
        let x1 = frame.size.width / 2 + r*cos(startAngle)
        let y1 = frame.size.width / 2 + r*sin(startAngle)
        path.move(to: CGPoint(x: x1, y: y1))
        path.addArc(withCenter: CGPoint(x: frame.size.width / 2,y: frame.size.width / 2), radius: frame.size.width / 2, startAngle:startAngle, endAngle:endAngle, clockwise: true)
        path.addQuadCurve(to: CGPoint(x: x1, y: y1), controlPoint: CGPoint(x: frame.width/2, y: frame.height/2))

        path.close()
        return path.cgPath
    }
}

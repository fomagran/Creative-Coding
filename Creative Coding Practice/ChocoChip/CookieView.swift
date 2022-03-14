//
//  CookieView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/13.
//

import UIKit

class CookieView: UIView {
    
    let shapeLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor(red: 123/255.0, green: 63/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        //1부터 180 사이까지 가능
        updateBezierPath(angle:60)
        layer.addSublayer(shapeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateBezierPath(angle:Int) {
        let pivot = 270
        let startAngle = pivot+angle > 360 ? (pivot+angle) - 360 : pivot+angle
        var endAngle = 0
        if 1...90 ~= startAngle {
            endAngle = 90 + (90-startAngle)
        }else if 270...360 ~= startAngle{
            endAngle = 180 + (360-startAngle)
        }
        print(startAngle,endAngle)
        let r = frame.width/2
        let path = UIBezierPath()
        let x1 = frame.size.width / 2 + r*cos(CGFloat.pi/180*CGFloat(startAngle))
        let y1 = frame.size.width / 2 + r*sin(CGFloat.pi/180*CGFloat(startAngle))
        path.move(to: CGPoint(x: x1, y: y1))
        path.addArc(withCenter: CGPoint(x: frame.size.width / 2,y: frame.size.width / 2), radius: frame.size.width / 2, startAngle:CGFloat.pi/180*CGFloat(startAngle), endAngle:CGFloat.pi/180*CGFloat(endAngle), clockwise: true)
        path.addQuadCurve(to: CGPoint(x: x1, y: y1), controlPoint: CGPoint(x: frame.width/2, y: frame.height/180*CGFloat(angle)))
        path.close()
        shapeLayer.path = path.cgPath
    }
}

//
//  LPView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit

class LPView: UIView {
    
    let title:UILabel = {
        let label = UILabel()
        label.text = "Fomagran"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawLP()
        title.frame = CGRect(x:bounds.midX-50, y: bounds.midY-50, width: 100, height: 100)
        addSubview(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLP() {
        var radius = frame.width
        for i in 0..<10 {
            radius -= 10
            if i == 0 {
                drawCircle(radius, 0.0,.black)
                continue
            }
            if i == 9 {
                drawCircle(radius, 0.5, .systemBlue)
                continue
            }
            drawCircle(radius, 0.5,.black)
        }
    }
    
    func drawCircle(_ radius:CGFloat,_ lineWidth:CGFloat,_ fillColor:UIColor) {
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius:radius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        layer.addSublayer(circleLayer)
    }

}

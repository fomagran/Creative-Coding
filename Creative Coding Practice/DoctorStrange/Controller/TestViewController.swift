//
//  TestViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/19.
//

import UIKit

class TestViewController: UIViewController {
    let redDot1 = UIView()
    let redDot2 = UIView()
    let redDot3 = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
       circle()
        redDot1.frame = CGRect(x: 495, y: 495, width: 10, height: 10)
        redDot1.backgroundColor = .red
        view.addSubview(redDot1)
        redDot2.frame = CGRect(x: 495, y: 295, width: 10, height: 10)
        redDot2.backgroundColor = .blue
        view.addSubview(redDot2)
        
        drawLine(c1: redDot1.center, c2: redDot2.center)
        
        for i in 0..<4 {
            let p = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 10))
            p.backgroundColor = .red
            let startAngle = CGFloat.pi/180 * (198 - CGFloat(i)*72)
            let point = CGPoint(x: redDot1.center.x + 200 * cos(startAngle),
                                y: redDot1.center.y + 200 * sin(startAngle))
            p.center = point
            view.addSubview(p)
            
        }
    }
    
    func circle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 500, y: 500), radius: CGFloat(200), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        view.layer.addSublayer(shapeLayer)
    }
    
    func drawLine(c1:CGPoint,c2:CGPoint) {
        let path = UIBezierPath()
        path.move(to: c1)
        path.addLine(to: c2)
        
        let pathLayer = CAShapeLayer()
        pathLayer.frame = view.bounds
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = UIColor.lightGray.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 2
        pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
        view.layer.addSublayer(pathLayer)
    }
}

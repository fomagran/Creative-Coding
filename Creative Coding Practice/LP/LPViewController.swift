//
//  LPViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit

class LPViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        drawLP()
    }
    
    func drawLP() {
        let radius:[CGFloat] = [150,140,130,120,110,100,90,80,70,60,50]
        for i in 0..<radius.count {
            if i == 0 {
                drawCircle(radius[i], 0.0,.black)
                continue
            }
            if i == radius.count-1 {
                drawCircle(radius[i], 0.5, .systemBlue)
                continue
            }
            drawCircle(radius[i], 0.5,.black)
        }
    }
    
    func drawCircle(_ radius:CGFloat,_ lineWidth:CGFloat,_ fillColor:UIColor) {
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.midX, y: view.bounds.midY), radius:radius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        view.layer.addSublayer(circleLayer)
    }
}

//
//  LPViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit

class LPViewController: UIViewController {
    
    let radius:[CGFloat] = [150,140,130,120,110,100,90,80,70,60,50]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        for i in 0..<radius.count {
            if i == 0 {
                drawCircle(radius[i], 0.0)
                continue
            }
            drawCircle(radius[i], 0.5)
        }
    }
    
    func drawCircle(_ radius:CGFloat,_ lineWidth:CGFloat) {
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.midX, y: view.bounds.midY), radius:radius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        view.layer.addSublayer(circleLayer)
    }
}

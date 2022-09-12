//
//  BezierViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/20.
//

import UIKit
import EasierPath

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let easierPath = EasierPath(100,100)
                    .right(100)
                    .curve(to:.down(200), .bezier(.rightDown(50,50), .leftDown(25,150)))
                    .left(100)
                    .curve(to:.up(200), .bezier(.rightUp(25,50), .leftUp(50,150)))
        
        let layer = easierPath.makeGradientLayer(startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5), gradientColors: [UIColor.red.cgColor,UIColor.blue.cgColor])
        view.layer.addSublayer(layer)
    }
}

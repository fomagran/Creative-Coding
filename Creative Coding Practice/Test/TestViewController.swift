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
                    .curve(.down(200), .bezier(.rightDown(50,50), .leftDown(25,150)))
                    .left(100)
                    .curve(.up(200), .bezier(.rightUp(25,50), .leftUp(50,150)))
        
        let layer = easierPath.makeLayer(3,.white,.systemPink)
        view.layer.addSublayer(layer)
    }
}

//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit
import EasierPath

class WaterViewController: UIViewController {
    
    private var timer : Timer?
    var y:CGFloat = 0
    var add:CGFloat = 1
    var h:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    private func addCurve() {
        view.layer.sublayers = nil
        let easierPath:EasierPath = EasierPath(view.center.x-100, view.center.y-h)
        easierPath.curve(to: .right(200), .bezier(.rightUp(75,y), .rightDown(150,y)))
        easierPath.leftDown(20, 100+h).left(160).leftUp(20, 100+h)
        let layer = easierPath.makeLayer(lineWidth: 1, lineColor: .black, fillColor: .systemBlue)
        view.layer.addSublayer(layer)
    }
    
    //MARK:- @objc Functions
    
    @objc func timerCallback() {
        
        if y > 30 {
            add = -1
        }
        
        if y < -30 {
            add = 1
        }
        
        y += add
        
        if h < 100 {
            h += 1
        }
        
        addCurve()
    }
    
}

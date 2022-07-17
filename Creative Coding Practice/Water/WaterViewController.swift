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
        drawBorderShape()
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    private func animateWave() {
        if view.layer.sublayers?.count ?? 0 > 1 {
            view.layer.sublayers!.removeLast()
        }
        let easierPath:EasierPath = EasierPath(view.center.x-100, view.center.y+150-h)
        easierPath
            .curve(to:
                .right(100),
                .bezier(.rightUp(25,y), .rightDown(75,y)))
            .down(h)
            .left(100)
            .up(h)
        
        let layer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:.systemBlue.withAlphaComponent(0.7))
        view.layer.addSublayer(layer)
    }
    
    func drawWaterShape() {
        if view.layer.sublayers?.count ?? 0 > 1 {
            view.layer.sublayers!.removeLast()
        }
        let easierPath:EasierPath = EasierPath(view.center.x-100, view.center.y+150-h)
        easierPath
            .right(100)
            .down(150)
            .left(100)
            .up(150)
            .end()
        
        let layer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:.systemBlue.withAlphaComponent(0.7))
        view.layer.addSublayer(layer)
    }
    
    func drawBorderShape() {
        let easierPath:EasierPath = EasierPath(view.center.x-100, view.center.y-50)
        easierPath
            .down(200)
            .right(100)
            .up(200)
            .leftUp(30, 50)
            .up(10)
            .left(40)
            .down(10)
            .leftDown(30, 50)
            .end()
        
        let layer = easierPath.makeLayer(lineWidth: 3, lineColor: .black, fillColor: .clear)
        view.layer.addSublayer(layer)
    }
    
    //MARK:- @objc Functions
    
    @objc func timerCallback() {
        add = abs(y) == 15 ? -add : add
        y += add

        if h < 150 {
            h += 1
            animateWave()
        }else {
            timer?.invalidate()
            drawWaterShape()
        }
    }
    
}

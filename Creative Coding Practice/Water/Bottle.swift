//
//  Bottle.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/07/16.
//

import UIKit
import EasierPath

class Bottle: UIView {
    
    //MARK: Properties
    
    private var timer : Timer?
    private var y:CGFloat = 0
    private var add:CGFloat = 1
    private var waterHeight:CGFloat = 0
    private var percent: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(_ percent:CGFloat) {
        drawBorderShape()
        self.percent = percent
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }

    private func animateWave() {
        if layer.sublayers?.count ?? 0 > 1 {
            layer.sublayers!.removeLast()
        }
        let bottom = frame.height
        let easierPath:EasierPath = EasierPath(0, bottom-waterHeight)
        easierPath
            .curve(to:
                    .right(frame.width),
                   .bezier(.rightUp(frame.width/4,y), .rightDown(frame.width/4*3,y)))
            .down(waterHeight)
            .left(frame.width)
            .up(waterHeight)
            .end()
        
        let waterLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:.systemBlue.withAlphaComponent(0.7))
        layer.addSublayer(waterLayer)
    }
    
    func drawWaterShape() {
        if layer.sublayers?.count ?? 0 > 1 {
            layer.sublayers!.removeLast()
        }
        let bottom = frame.height
        let easierPath:EasierPath = EasierPath(0,bottom-waterHeight)
        easierPath
            .right(frame.width)
            .down(frame.height/4*3)
            .left(frame.width)
            .up(frame.height/4*3)
            .end()
        
        let waterLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:.systemBlue.withAlphaComponent(0.7))
        layer.addSublayer(waterLayer)
    }
    
    func drawBorderShape() {
        let easierPath:EasierPath = EasierPath(0,0)
        easierPath
            .down(frame.height)
            .right(frame.width)
            .up(frame.height)
            .leftUp(frame.width/3,frame.height/5)
            .up(frame.height/20)
            .left(frame.width - frame.width/3*2)
            .down(frame.height/20)
            .leftDown(frame.width/3,frame.height/5)
            .end()
        
        let waterLayer = easierPath.makeLayer(lineWidth: 3, lineColor: .black, fillColor: .clear)
        layer.addSublayer(waterLayer)
    }
    
    //MARK:- @objc Functions
    
    @objc func timerCallback() {
        add = abs(y) == 15 ? -add : add
        y += add

        if waterHeight < frame.height * percent {
            waterHeight += 1
            animateWave()
        }else {
            timer?.invalidate()
            drawWaterShape()
        }
    }
}

//
//  Water.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/07/24.
//

import UIKit
import EasierPath

class Water: UIView {
    private var y:CGFloat = 0
    private var add:CGFloat = 1
    private var timer : Timer?
    private var percent: CGFloat = 0
    var waterHeight:CGFloat = 0
    private var waterColor: UIColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 1)
    private var isShrink: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shrinkWater() {
        waterHeight -= 0.01
        if layer.sublayers?.count ?? 0 >= 1 {
            layer.sublayers!.removeLast()
        }
        let easierPath =  waterShape()
        let waterLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:waterColor)
        layer.addSublayer(waterLayer)
    }
    
    func startFill(percent:CGFloat) {
        self.percent = percent
        timer = Timer.scheduledTimer(timeInterval:0.04, target: self, selector: #selector(fillWater), userInfo: nil, repeats: true)
    }
    
    func drawShape(isWave: Bool) {
        if layer.sublayers?.count ?? 0 >= 1 {
            layer.sublayers!.removeLast()
        }
        
        let easierPath = isWave ? waveShape() : waterShape()
        let waterLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:waterColor)
        layer.addSublayer(waterLayer)
    }
    
    private func waveShape() -> EasierPath {
        let easierPath:EasierPath = EasierPath(frame.width/4,frame.height-waterHeight)
        easierPath
            .curve(to:
                    .right(frame.width/2),
                   .bezier(.rightUp(frame.width/8*2,y), .rightDown(frame.width/8*6,y)))
            .down(waterHeight)
            .left(frame.width/2)
            .up(waterHeight)
            .end()
        return easierPath
    }
    
    private func waterShape() -> EasierPath {
        let easierPath:EasierPath = EasierPath(0,frame.height - waterHeight)
        easierPath
            .down(waterHeight)
            .right(frame.height)
            .up(waterHeight)
            .end()
        return easierPath
    }
    
    //MARK:- @objc Functions
    
    @objc func fillWater() {
        add = abs(y) == 15 ? -add : add
        y += add
        
        if waterHeight < frame.height * percent {
            waterHeight += 1
            drawShape(isWave: true)
        }else {
            timer?.invalidate()
            drawShape(isWave: false)
        }
    }

}

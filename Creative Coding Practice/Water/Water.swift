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
    private var waterHeight:CGFloat = 0
    private var waterColor: UIColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = waterColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startFill(percent:CGFloat) {
        self.percent = percent
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(fillWater), userInfo: nil, repeats: true)
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
        let easierPath:EasierPath = EasierPath(0,frame.height-waterHeight)
        easierPath
            .curve(to:
                    .right(frame.width),
                   .bezier(.rightUp(frame.width/4,y), .rightDown(frame.width/4*3,y)))
            .down(waterHeight)
            .left(frame.width)
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

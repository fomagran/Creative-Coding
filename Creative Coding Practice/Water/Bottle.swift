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
    
    private var timer1 : Timer?
    private var timer : Timer?
    private var y:CGFloat = 0
    private var add:CGFloat = 1
    private var waterHeight:CGFloat = 0
    private var percent: CGFloat = 0
    private var waterColor: UIColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 0.5)
    private lazy var entrance: CGFloat = frame.height/5 + frame.height/20
    private lazy var body: CGFloat = frame.height - entrance
    var left: CGFloat = 0
    var test: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(_ percent:CGFloat) {
        drawBorderShape()
        self.percent = percent
        timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(fillWater), userInfo: nil, repeats: true)
    }
    
    private func animateWave() {
        if layer.sublayers?.count ?? 0 > 3 {
            layer.sublayers!.removeLast()
            layer.sublayers!.removeLast()
            layer.sublayers!.removeLast()
        }

        let easierPath:EasierPath = EasierPath(0,frame.height-waterHeight)
        easierPath
            .curve(to:
                    .right(frame.width),
                   .bezier(.rightUp(frame.width/4,y), .rightDown(frame.width/4*3,y)))
            .down(waterHeight)
            .left(frame.width)
            .up(waterHeight)
            .end()
        
        let waterLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:waterColor)
        layer.addSublayer(waterLayer)
        
        drawBottleSide()
    }
    
    func drawWaterShape() {
        if layer.sublayers?.count ?? 0 > 3 {
            layer.sublayers!.removeLast()
            layer.sublayers!.removeLast()
            layer.sublayers!.removeLast()
        }
        
        let easierPath:EasierPath = EasierPath(0,frame.height-waterHeight-left)
        easierPath
            .down(waterHeight+left)
            .right(frame.width)
            .up(waterHeight-left)
            .leftUp(frame.width,(waterHeight+left)*left/100)
            .end()
        
        let waterLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor:waterColor)
        layer.addSublayer(waterLayer)
        
        drawBottleSide()
    }
    
    func drawBorderShape() {
        let easierPath:EasierPath = EasierPath(0,0)
        easierPath
            .down(frame.height)
            .right(frame.width)
            .up(frame.height)
            .left(frame.width)
            .end()
        
        let waterLayer = easierPath.makeLayer(lineWidth: 0, lineColor: .black, fillColor: .white)
        layer.addSublayer(waterLayer)
        
        drawBottleSide()
        
    }
    
    func drawBottleSide() {
        let leftSide: EasierPath = EasierPath(0,0)
        leftSide
            .down(entrance)
            .rightUp(frame.width/3, frame.height/5)
            .up(frame.height/20)
            .left(frame.height/5)
            .end()
        
        let rightSide: EasierPath = EasierPath(frame.width,0)
        rightSide
            .down(entrance)
            .leftUp(frame.width/3, frame.height/5)
            .up(frame.height/20)
            .right(frame.height/5)
            .end()
        
        let leftLayer = leftSide.makeLayer(lineWidth: 5, lineColor: .black, fillColor: .black)
        layer.addSublayer(leftLayer)
        
        let rightLayer = rightSide.makeLayer(lineWidth: 5, lineColor: .black, fillColor: .black)
        layer.addSublayer(rightLayer)
    }
    
    //MARK:- @objc Functions
    
    @objc func fillWater() {
        add = abs(y) == 15 ? -add : add
        y += add
        
        if waterHeight < frame.height * percent {
            waterHeight += 1
            animateWave()
        }else {
            timer?.invalidate()
            timer1 = Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(leanToLeft), userInfo: nil, repeats: true)
            drawWaterShape()
        }
    }
    
    @objc func leanToLeft() {
        if left <= 100 {
            left += 1
        } else {
            timer1?.invalidate()
        }
        drawWaterShape()

    }
}

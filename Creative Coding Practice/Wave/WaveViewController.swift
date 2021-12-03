//
//  WaveViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/01.
//

import UIKit

struct Point {
    var x:CGFloat
    var y:CGFloat
    var max:CGFloat
    var min:CGFloat
    var addY:CGFloat
    var center:CGPoint {
        return CGPoint(x: x, y: y)
    }
}

class WaveViewController: UIViewController {

    private var timer : Timer?
    private var points:[Point] = []
    private var h:CGFloat = 0
    private var lines:[CAShapeLayer] = []
    private var lineCount:Int = 3
    private var dotCount:Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK:- Help Functions
    
    func configure() {
        let w:CGFloat = self.view.frame.width/CGFloat(dotCount+1)
        let center = self.view.center.y
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        h = self.view.center.y
        lines = Array(repeating: CAShapeLayer(), count: lineCount)
        for i in 1...dotCount {
            let x:CGFloat = w*CGFloat(i)
            let y:CGFloat = center
            let max:CGFloat = CGFloat.random(in: 30...120)
            let min:CGFloat = CGFloat.random(in: (-120)...(-30))
            let addY:CGFloat = CGFloat(i%2) == 0 ? -1:1
            points.append(Point(x: x, y: y, max: max, min: min, addY: addY))
        }
    }
    
    private func addCurve(line:CAShapeLayer,p1:CGPoint,p2:CGPoint,lineColor:UIColor) {
        line.removeFromSuperlayer()
        let height:CGFloat = self.view.frame.height
        let width:CGFloat = self.view.frame.width
        let linePath = UIBezierPath()
        linePath.move(to:CGPoint(x: 0, y:height))
        linePath.addLine(to:CGPoint(x: 0, y:height/2))
        linePath.addCurve(to:CGPoint(x: width, y:height/2), controlPoint1:p1, controlPoint2:p2)
        linePath.addLine(to: CGPoint(x: width, y: height))
        line.path = linePath.cgPath
        line.fillColor = lineColor.cgColor
        view.layer.addSublayer(line)
    }
    
    //MARK:- @objc Functions
    
    @objc
    func timerCallback() {
        for i in 0..<points.count {
            points[i].y += points[i].addY
            if points[i].y > h + points[i].max  || points[i].y < h + points[i].min {
                points[i].addY = -(points[i].addY)
            }
        }
        
        addCurve(line: lines[0], p1: points[0].center, p2: points[2].center, lineColor: UIColor.systemGreen.withAlphaComponent(0.4))
        addCurve(line: lines[1], p1: points[1].center, p2:points[3].center, lineColor: UIColor.systemPink.withAlphaComponent(0.4))
        addCurve(line: lines[2], p1: points[0].center, p2: points[3].center, lineColor: UIColor.systemBlue.withAlphaComponent(0.4))
    }
}

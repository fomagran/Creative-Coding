//
//  WaveViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/01.
//

import UIKit

class WaveViewController: UIViewController {
    
    let redDot1:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let redDot2:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let redDot3:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let redDot4:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let redDot5:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let redDot6:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = .clear
        return view
    }()

    
    private var line1 = CAShapeLayer()
    private var line2 = CAShapeLayer()
    private var line3 = CAShapeLayer()
    
    var timer : Timer?
    var plus2:CGFloat = 1
    var plus3:CGFloat = -1
    var plus4:CGFloat = 1
    var plus5:CGFloat = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.moveRedDot(redDot: self.redDot2,duration: 0.8,move: 100)
//        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.moveRedDot(redDot: self.redDot3,duration: 0.8,move: 100)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.moveRedDot(redDot: self.redDot4,duration: 0.8,move: 100)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.77) {
//            self.moveRedDot(redDot: self.redDot5,duration: 0.8,move: 100)
//        }
    }
    
    @objc func timerCallback() {
        redDot2.center.y += plus2
        redDot3.center.y += plus3
        redDot4.center.y += plus4
        redDot5.center.y += plus5
        
        if redDot2.center.y == self.view.center.y + 180  || redDot2.center.y == self.view.center.y - 80 {
            plus2 = -(plus2)
        }
        
        if redDot3.center.y == self.view.center.y + 200  || redDot3.center.y == self.view.center.y - 100 {
            plus3 = -(plus3)
        }
        
        
        if redDot4.center.y == self.view.center.y + 70  || redDot4.center.y == self.view.center.y - 170 {
            plus4 = -(plus4)
        }
        
        if redDot5.center.y == self.view.center.y + 60  || redDot5.center.y == self.view.center.y - 120 {
            plus5 = -(plus5)
        }
        
        addCurve1()
        addCurve2()
        addCurve3()
    }
    
    func setLayout() {
        let w = self.view.frame.width/5
        redDot1.frame = CGRect(x:0, y:self.view.center.y, width: 10, height: 10)
        redDot1.layer.cornerRadius = 5
        self.view.addSubview(redDot1)
        
        redDot2.frame = CGRect(x:w*1, y:self.view.center.y, width: 10, height: 10)
        redDot2.layer.cornerRadius = 5
        self.view.addSubview(redDot2)
        
        redDot3.frame = CGRect(x:w*2, y:self.view.center.y, width: 10, height: 10)
        redDot3.layer.cornerRadius = 5
        self.view.addSubview(redDot3)
        
        redDot4.frame = CGRect(x:w*3, y:self.view.center.y, width: 10, height: 10)
        redDot4.layer.cornerRadius = 5
        self.view.addSubview(redDot4)
        
        redDot5.frame = CGRect(x:w*4, y:self.view.center.y, width: 10, height: 10)
        redDot5.layer.cornerRadius = 5
        self.view.addSubview(redDot5)
        
        redDot6.frame = CGRect(x:self.view.frame.width-10, y:self.view.center.y, width: 10, height: 10)
        redDot6.layer.cornerRadius = 5
        
        line1.fillColor = UIColor.systemBlue.withAlphaComponent(0.4).cgColor
        line2.fillColor = UIColor.systemBlue.withAlphaComponent(0.3).cgColor
        line3.fillColor = UIColor.systemBlue.withAlphaComponent(0.2).cgColor
        self.view.addSubview(redDot6)
    }
    
    private func addCurve1() {
        line1.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to:CGPoint(x: 0, y: self.view.frame.height))
        linePath.addLine(to:CGPoint(x: 0, y: self.view.center.y))
        linePath.addCurve(to:CGPoint(x: self.view.frame.width, y: self.view.center.y), controlPoint1: redDot2.center, controlPoint2: redDot4.center)
        linePath.addLine(to: CGPoint(x: self.view.frame.width, y: self.view.frame.height))
        line1.path = linePath.cgPath
        line1.strokeColor = UIColor.clear.cgColor
        line1.lineWidth = 1
        view.layer.addSublayer(line1)
    }
    
    private func addCurve2() {
        line2.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to:CGPoint(x: 0, y: self.view.frame.height))
        linePath.addLine(to:CGPoint(x: 0, y: self.view.center.y))
        linePath.addCurve(to:CGPoint(x: self.view.frame.width, y: self.view.center.y), controlPoint1: redDot3.center, controlPoint2: redDot5.center)
        linePath.addLine(to: CGPoint(x: self.view.frame.width, y: self.view.frame.height))
        line2.path = linePath.cgPath
        line2.strokeColor = UIColor.clear.cgColor
        line2.lineWidth = 1
        view.layer.addSublayer(line2)
    }
    
    private func addCurve3() {
        line3.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to:CGPoint(x: 0, y: self.view.frame.height))
        linePath.addLine(to:CGPoint(x: 0, y: self.view.center.y))
        linePath.addCurve(to:CGPoint(x: self.view.frame.width, y: self.view.center.y), controlPoint1: redDot2.center, controlPoint2: redDot5.center)
        linePath.addLine(to: CGPoint(x: self.view.frame.width, y: self.view.frame.height))
        line3.path = linePath.cgPath
        line3.strokeColor = UIColor.clear.cgColor
        line3.lineWidth = 1
        view.layer.addSublayer(line3)
    }
    
    func moveRedDot(redDot:UIView,duration:CGFloat,move:CGFloat) {
        UIView.animate(withDuration:duration) {
            redDot.center.y = self.view.center.y + move
        } completion: { _ in
            UIView.animate(withDuration: duration) {
                redDot.center.y = self.view.center.y - move
            } completion: { _ in
                self.moveRedDot(redDot:redDot,duration:duration,move: move)
            }
        }
    }
}

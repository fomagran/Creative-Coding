//
//  BrokenGlassViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/02/06.
//

import UIKit

class BrokenGlassViewController: UIViewController {
    
    var glass:UIView = {
        let v:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        v.backgroundColor = .white.withAlphaComponent(0.25)
        v.layer.cornerRadius = 10
        return v
    }()
    
    var dot:UIView = {
        let v:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        v.backgroundColor = .black
        v.layer.cornerRadius = 2.5
        return v
    }()
    
    var gradientLayer = CAGradientLayer()
    
    var isBroken:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [UIColor.magenta.cgColor, UIColor.cyan.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.95)
          gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.05)
        view.layer.addSublayer(gradientLayer)
        glass.center  = view.center
        glass.layer.shadowColor = UIColor.black.cgColor
        glass.layer.shadowOpacity = 0.1
        glass.layer.shadowOffset = CGSize(width: 0, height: 0)
        glass.layer.shadowRadius = 10
        glass.layer.shadowPath = UIBezierPath(rect: glass.bounds).cgPath
        self.view.addSubview(glass)
        self.view.addSubview(dot)
        setTapGesture()
    }
    
    func getEdges() {
        let edges = [CGPoint(x:view.center.x - 100,y:view.center.y),
                     CGPoint(x:view.center.x - 100,y:view.center.y-75),
                     CGPoint(x:view.center.x - 100,y:view.center.y+75),
                     CGPoint(x:view.center.x + 100,y:view.center.y),
                     CGPoint(x:view.center.x + 100,y:view.center.y-75),
                     CGPoint(x:view.center.x + 100,y:view.center.y+75),
                     CGPoint(x:view.center.x,y:view.center.y - 150),
                     CGPoint(x:view.center.x-50,y:view.center.y - 150),
                     CGPoint(x:view.center.x+50,y:view.center.y - 150),
                     CGPoint(x:view.center.x,y:view.center.y + 150),
                     CGPoint(x:view.center.x-50,y:view.center.y + 150),
                     CGPoint(x:view.center.x+50,y:view.center.y + 150)]
        for edge in edges {
            let v = UIView(frame: CGRect(x: edge.x, y: edge.y, width: 2, height: 2))
            self.view.addSubview(v)
            let line = CAShapeLayer()
            addLine(line: line, start: dot.center, end: v.center)
            drawLineAntimation(line)
        }
    }
    
    func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGlass(_:)))
        glass.addGestureRecognizer(tap)
    }
    
    func drawLineAntimation(_ pathLayer:CAShapeLayer) {
        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 2.0
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathLayer.add(pathAnimation, forKey: "strokeEnd")
    }
    
    @objc func tapGlass(_ sender:UITapGestureRecognizer) {
        if !isBroken {
            dot.center = sender.location(in: view)
            getEdges()
        }
        isBroken = true
    }
}

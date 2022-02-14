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
    var squareView:UIView!
    var collision: UICollisionBehavior!
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var itemBehavior:UIDynamicItemBehavior!
    
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
        doCollision()
    }
    
    func doCollision() {
        let squareSize = CGSize(width: 30.0, height: 30.0)
        let centerX = self.view.bounds.midX - (squareSize.width/2)
        let centerY = self.view.bounds.midY - (squareSize.height/2)
        var squares:[UIView] = []
        let color:[UIColor] = [.red,.blue,.green,.orange,.black,.systemPink,.systemTeal,.purple,.systemIndigo]
        let centers:[CGPoint] = [CGPoint(x: centerX-glass.frame.width/2-10, y: centerY-glass.frame.height/2),
                                 CGPoint(x: centerX, y: centerY-glass.frame.height/2),
                                 CGPoint(x: centerX+glass.frame.width/2+10, y: centerY-glass.frame.height/2),
                                 CGPoint(x: centerX-glass.frame.width/2-20, y: centerY),
                                 CGPoint(x: centerX, y: centerY),
                                 CGPoint(x: centerX+glass.frame.width/2-30, y: centerY),
                                 CGPoint(x: centerX-glass.frame.width/2+20, y: centerY+glass.frame.height/2),
                                 CGPoint(x: centerX+10, y: centerY+glass.frame.height/2),
                                 CGPoint(x: centerX+glass.frame.width/2-30, y: centerY+glass.frame.height/2)]
        for (i,c) in color.enumerated() {
            let frame = CGRect(origin: centers[i], size: squareSize)
            let v = UIView()
            v.backgroundColor = c
            v.frame = frame
            view.addSubview(v)
            squares.append(v)
        }
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items:squares)
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items:squares)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        itemBehavior = UIDynamicItemBehavior(items:squares)
        itemBehavior.elasticity = 0.8
        itemBehavior.density = 2
        animator.addBehavior(itemBehavior)
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

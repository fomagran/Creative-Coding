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
    
    var glassPiece:UIImageView = {
        let iv:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        return iv
    }()
    
    var gradientLayer = CAGradientLayer()
    var isBroken:Bool = false
    var squareView:UIView!
    var collision: UICollisionBehavior!
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var itemBehavior:UIDynamicItemBehavior!
    var bezierPath:UIBezierPath!
    var lines:[CAShapeLayer] = []
    var bezierPaths:[UIBezierPath] = []
    
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
        view.addSubview(glassPiece)
        glassPiece.center = CGPoint(x: 100, y: 100)
        addCurve()
    }
    
    func addCurve() {
        let line = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: view.center)
        path.addQuadCurve(to: CGPoint(x: 100, y: 100), controlPoint:CGPoint(x: 200, y: 200))
        line.path = path.cgPath
        line.strokeColor = UIColor.black.cgColor
        line.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(line)
        
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = path.cgPath
        flightAnimation.calculationMode = CAAnimationCalculationMode.paced
        flightAnimation.duration = 0.5
        flightAnimation.rotationMode = CAAnimationRotationMode.rotateAuto
        flightAnimation.repeatCount = 1
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.addSubview(v)
        v.backgroundColor = .black
        v.layer.add(flightAnimation, forKey: nil)
    }
    
    func doCollision() {
        var squares:[UIView] = []
        for _ in 0..<bezierPaths.count {
            let random = CGFloat((-50...50).randomElement()!)
            let width =  CGFloat((10...100).randomElement()!)
            let height =  CGFloat((10...100).randomElement()!)
            let g = GlassPiece(frame: CGRect(x: view.center.x - random, y: view.center.y-random, width:width, height: height))
            view.addSubview(g)
            squares.append(g)
        }

        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items:squares)
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items:squares)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        itemBehavior = UIDynamicItemBehavior(items:squares)
        itemBehavior.elasticity = 0.4
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
            let b = UIBezierPath()
            bezierPaths.append(b)
            let line = CAShapeLayer()
            lines.append(line)
            addLineToGlass(line: line, start: dot.center, end: edge)
            drawLineAntimation(line)
        }
    }
    
    func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGlass(_:)))
        glass.addGestureRecognizer(tap)
    }
    
    func addLineToGlass(line:CAShapeLayer,start: CGPoint, end:CGPoint) {
        line.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.gray.cgColor
        line.lineWidth = 1
        view.layer.addSublayer(line)
    }
    
    func drawLineAntimation(_ pathLayer:CAShapeLayer) {
        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0.5
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathLayer.add(pathAnimation, forKey: "strokeEnd")
    }
    
    @objc func tapGlass(_ sender:UITapGestureRecognizer) {
        if !isBroken {
            dot.center = sender.location(in: view)
            getEdges()
            isBroken = true
        }else {
            glass.isHidden = true
            dot.isHidden = true
            doCollision()
            for line in lines {
                line.removeFromSuperlayer()
            }
        }
    }
}

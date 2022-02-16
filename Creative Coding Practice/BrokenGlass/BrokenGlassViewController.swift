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
    }
    
    func doCollision() {
        var squares:[UIView] = []
        for i in 0..<bezierPaths.count {
            let imageView = UIImageView(frame: CGRect(x:view.center.x-50, y:view.center.y-50, width:100, height: 100))
            let piece = UIImage(named:"glass.png")?.imageByApplyingMaskingBezierPath(bezierPaths[i], imageView.frame)
            imageView.image = piece
            view.addSubview(imageView)
            squares.append(imageView)
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
        let left = view.center.x - 100
        let right = view.center.x + 100
        let top = view.center.y - 150
        let bottom = view.center.y + 150
        
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
        var past = CGPoint(x:0,y:0)
        for edge in edges {
            let b = UIBezierPath()
            if edge.x == left && past.x == left {
                print("left","left")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:left, y:edge.y))
                b.addLine(to: CGPoint(x:left, y:past.y))
            }else if edge.x == right && past.x == right {
                print("right","right",edge,past)
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:right, y:edge.y))
                b.addLine(to: CGPoint(x:right, y:past.y))
            }else if edge.y == top && past.y == top {
                print("top","top")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:edge.x, y:top))
                b.addLine(to: CGPoint(x:past.x, y:top))
            }else if edge.y == bottom && edge.y == bottom {
                print("bottom","bottom")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:edge.x, y:bottom))
                b.addLine(to: CGPoint(x:past.x, y:bottom))
            }else if edge.x == left && past.y == top {
                print("left","top")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:left, y:edge.y))
                b.addLine(to: CGPoint(x:left, y:top))
                b.addLine(to: CGPoint(x:past.x, y:top))
            }else if edge.y == top && past.x == left {
                print("top","left")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:left, y:edge.y))
                b.addLine(to: CGPoint(x:left, y:top))
                b.addLine(to: CGPoint(x:past.x, y:top))
            }else if edge.x == left && past.y == bottom {
                print("left","bottom")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:left, y:edge.y))
                b.addLine(to: CGPoint(x:left, y:bottom))
                b.addLine(to: CGPoint(x:past.x, y:bottom))
            }else if edge.y == bottom && past.x == left {
                print("bottom","left")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:left, y:edge.y))
                b.addLine(to: CGPoint(x:left, y:bottom))
                b.addLine(to: CGPoint(x:past.x, y:bottom))
            }else if edge.x == right && past.y == top {
                print("right","top")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:right, y:edge.y))
                b.addLine(to: CGPoint(x:right, y:top))
                b.addLine(to: CGPoint(x:past.x, y:top))
            }else if edge.y == top && past.x == right {
                print("top","right")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:right, y:edge.y))
                b.addLine(to: CGPoint(x:right, y:top))
                b.addLine(to: CGPoint(x:past.x, y:top))
            }else if edge.x == right && past.y == bottom {
                print("right","bottom")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:right, y:edge.y))
                b.addLine(to: CGPoint(x:right, y:bottom))
                b.addLine(to: CGPoint(x:past.x, y:bottom))
            }else if edge.y == bottom && past.x == right {
                print("bottom","right")
                b.move(to: CGPoint(x: dot.center.x, y:dot.center.y))
                b.addLine(to: CGPoint(x:right, y:edge.y))
                b.addLine(to: CGPoint(x:right, y:bottom))
                b.addLine(to: CGPoint(x:past.x, y:bottom))
                b.close()
            }else {
                past = edge
                continue
            }
            past = edge
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

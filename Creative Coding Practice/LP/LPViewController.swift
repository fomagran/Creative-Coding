//
//  LPViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit

class LPViewController: UIViewController {
    
    var bezier: QuadBezier!
    
    let pathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
    
    var shape: CircleView = {
        let shape = CircleView()
        shape.backgroundColor = .red
        shape.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        return shape
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(pathLayer)
        view.addSubview(shape)
        setPanGesture()
        self.view.backgroundColor = .white
        bezier = buildCurvedPath()
        pathLayer.path = bezier.path.cgPath
        shape.center = bezier.point(at: 0.5)
    }
    
    private func setPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dragSquare(_:)))
        shape.addGestureRecognizer(panGesture)
    }
    
    //MARK:- Actions
    
    @objc func dragSquare(_ sender: UIPanGestureRecognizer) {
        updatePosition(sender.location(in: self.view))
    }
    
    func buildCurvedPath() -> QuadBezier {
        let bounds = view.bounds
        let point1 = CGPoint(x: bounds.maxX, y: bounds.minY + 100)
        let point2 = CGPoint(x: bounds.maxX, y: bounds.maxY - 100)
        let controlPoint = CGPoint(x: bounds.maxX - 300, y: bounds.midY)
        let path = QuadBezier(point1: point1, point2: point2, controlPoint: controlPoint)
        return path
    }
    
    func updatePosition(_ position:CGPoint) {
        let location = position
        let t = (location.y - view.bounds.minY) / view.bounds.height
        shape.center = bezier.point(at: t)
    }
    
    func drawLP() {
        let radius:[CGFloat] = [150,140,130,120,110,100,90,80,70,60,50]
        for i in 0..<radius.count {
            if i == 0 {
                drawCircle(radius[i], 0.0,.black)
                continue
            }
            if i == radius.count-1 {
                drawCircle(radius[i], 0.5, .systemBlue)
                continue
            }
            drawCircle(radius[i], 0.5,.black)
        }
    }
    
    func drawCircle(_ radius:CGFloat,_ lineWidth:CGFloat,_ fillColor:UIColor) {
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.bounds.midX, y: view.bounds.midY), radius:radius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = fillColor.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        view.layer.addSublayer(circleLayer)
    }
}

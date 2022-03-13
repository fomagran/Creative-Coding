//
//  ChocoChipViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/13.
//

import UIKit

class ChocoChipViewController: UIViewController {
    
    private let minimalHeight: CGFloat = 200.0
    private let maxWaveHeight: CGFloat = 250.0
    private let shapeLayer = CAShapeLayer()
    
    private var displayLink: CADisplayLink!
    private var animating = false {
        didSet {
            view.isUserInteractionEnabled = !animating
            displayLink.isPaused = !animating
        }
    }
    
    private let l3ControlPointView = UIView()
    private let l2ControlPointView = UIView()
    private let l1ControlPointView = UIView()
    private let cControlPointView = UIView()
    private let r1ControlPointView = UIView()
    private let r2ControlPointView = UIView()
    private let r3ControlPointView = UIView()

    override func loadView() {
        super.loadView()
        shapeLayer.fillColor = UIColor(red: 123/255.0, green: 63/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        shapeLayer.actions = ["position" : NSNull(), "bounds" : NSNull(), "path" : NSNull()]
        view.layer.addSublayer(shapeLayer)

        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(panGestureDidMove(_:)))
        view.addGestureRecognizer(panGesture)

        view.addSubview(l3ControlPointView)
        view.addSubview(l2ControlPointView)
        view.addSubview(l1ControlPointView)
        view.addSubview(cControlPointView)
        view.addSubview(r1ControlPointView)
        view.addSubview(r2ControlPointView)
        view.addSubview(r3ControlPointView)

        layoutControlPoints(baseHeight: view.frame.height - minimalHeight, waveHeight: 0.0, locationX: view.bounds.width / 2.0)
        updateShapeLayer()

        displayLink = CADisplayLink(target: self, selector: #selector(updateShapeLayer))
        displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        displayLink.isPaused = true
    }

    @objc func panGestureDidMove(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended || gesture.state == .failed || gesture.state == .cancelled {
            let centerY = view.frame.height - minimalHeight
            
            animating = true
            UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.57, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
                self.l3ControlPointView.center.y = centerY
                self.l2ControlPointView.center.y = centerY
                self.l1ControlPointView.center.y = centerY
                self.cControlPointView.center.y = centerY
                self.r1ControlPointView.center.y = centerY
                self.r2ControlPointView.center.y = centerY
                self.r3ControlPointView.center.y = centerY
                }, completion: { _ in
                    self.animating = false
            })
        } else {
            let additionalHeight = min(gesture.translation(in: view).y,0)
            
            let waveHeight = min(additionalHeight * 0.6, maxWaveHeight)
            let baseHeight = (view.frame.height - minimalHeight) + additionalHeight - waveHeight
            
            let locationX = gesture.location(in: gesture.view).x
            
            layoutControlPoints(baseHeight: baseHeight, waveHeight: waveHeight, locationX: locationX)
            updateShapeLayer()
        }
    }
    
    private func layoutControlPoints(baseHeight: CGFloat, waveHeight: CGFloat, locationX: CGFloat) {
        let width = view.bounds.width
        
        let minLeftX = min((locationX - width / 2.0) * 0.28, 0.0)
        let maxRightX = max(width + (locationX - width / 2.0) * 0.28, width)
        
        let leftPartWidth = locationX - minLeftX
        let rightPartWidth = maxRightX - locationX
        
        l3ControlPointView.center = CGPoint(x: minLeftX, y: baseHeight)
        l2ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.44, y: baseHeight)
        l1ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.71, y: baseHeight + waveHeight * 0.64)
        cControlPointView.center = CGPoint(x: locationX , y: baseHeight + waveHeight * 1.36)
        r1ControlPointView.center = CGPoint(x: maxRightX - rightPartWidth * 0.71, y: baseHeight + waveHeight * 0.64)
        r2ControlPointView.center = CGPoint(x: maxRightX - (rightPartWidth * 0.44), y: baseHeight)
        r3ControlPointView.center = CGPoint(x: maxRightX, y: baseHeight)
    }
    
    @objc func updateShapeLayer() {
        shapeLayer.path = currentPath()
    }
    
    private func currentPath() -> CGPath {
        let width = view.bounds.width
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: view.bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: l3ControlPointView.dg_center(usePresentationLayerIfPossible: animating).y))

        bezierPath.addCurve(to: l1ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint1: l3ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint2: l2ControlPointView.dg_center(usePresentationLayerIfPossible: animating))

        bezierPath.addCurve(to: r1ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint1: cControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint2: r1ControlPointView.dg_center(usePresentationLayerIfPossible: animating))

        bezierPath.addCurve(to: r3ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint1: r1ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint2: r2ControlPointView.dg_center(usePresentationLayerIfPossible: animating))
        bezierPath.addLine(to: CGPoint(x: width, y:view.bounds.maxY))
        
        bezierPath.close()
        return bezierPath.cgPath
    }
    
}

extension UIView {
  func dg_center(usePresentationLayerIfPossible: Bool) -> CGPoint {
      if usePresentationLayerIfPossible, let presentationLayer = layer.presentation() {
      return presentationLayer.position
    }
    return center
  }
}

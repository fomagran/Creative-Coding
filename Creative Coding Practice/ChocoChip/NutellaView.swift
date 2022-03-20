//
//  NutellaView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/18.
//

import Foundation
import UIKit

class NutellaView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setChocoSauce()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var startPoint:CGPoint = CGPoint(x:0,y:0)
    var didTouch:Bool = false
    private var isUP = false
    private lazy var minimalHeight: CGFloat = frame.height/2 - frame.height/5
    private lazy var maxWaveHeight: CGFloat = 0
    private let shapeLayer = CAShapeLayer()
    private var displayLink: CADisplayLink!
    private var animating = false {
        didSet {
            isUserInteractionEnabled = !animating
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
    
    func setChocoSauce() {
       shapeLayer.fillColor = UIColor(red: 81/255.0, green: 45/255.0, blue: 27/255.0, alpha: 1.0).cgColor
        shapeLayer.actions = ["position" : NSNull(), "bounds" : NSNull(), "path" : NSNull()]
        layer.addSublayer(shapeLayer)

        addSubview(l3ControlPointView)
        addSubview(l2ControlPointView)
        addSubview(l1ControlPointView)
        addSubview(cControlPointView)
        addSubview(r1ControlPointView)
        addSubview(r2ControlPointView)
        addSubview(r3ControlPointView)

        layoutControlPoints(baseHeight: frame.height-minimalHeight, waveHeight: 0.0, locationX: bounds.width / 4.0)
        updateShapeLayer()

        displayLink = CADisplayLink(target: self, selector: #selector(updateShapeLayer))
        displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        displayLink.isPaused = true
    }

    func touchNutella(_ state:String,_ location:CGPoint) {
        let location = CGPoint(x: location.x-50, y: location.y)
        if state == "Ended" {
            elasticAnimation()
        } else {
            let gapY = startPoint.y - location.y
            isUP = gapY > 0
            print(location.y,startPoint.y)
            let movingHegiht = -(location.y - startPoint.y)
            var waveHeight = min(movingHegiht, maxWaveHeight)
            let baseHeight = (frame.height - minimalHeight) - movingHegiht
            waveHeight = gapY < 0 ? waveHeight : 0
            if abs(gapY) < 200{
                layoutControlPoints(baseHeight: baseHeight, waveHeight: waveHeight, locationX: location.x)
                updateShapeLayer()
            }
        }
    }
    
    func elasticAnimation() {
        let centerY = frame.height - minimalHeight
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
    }
    
    private func layoutControlPoints(baseHeight: CGFloat, waveHeight: CGFloat, locationX: CGFloat) {
        let width = bounds.width
        let minLeftX = min((locationX - width / 2.0) * 0.28, 0.0)
        let maxRightX = max(width + (locationX - width / 2.0) * 0.28, width)
    
        let leftPartWidth = locationX - minLeftX
        let rightPartWidth = maxRightX - locationX
        
        var baseHeight = baseHeight
        if didTouch && isUP {
            baseHeight = baseHeight-50
        }
        let h = frame.height - minimalHeight
        l3ControlPointView.center = CGPoint(x: minLeftX, y:h)
        l2ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.44, y: h)
        l1ControlPointView.center = CGPoint(x: minLeftX + leftPartWidth * 0.71, y: h)
        cControlPointView.center = CGPoint(x: locationX , y: baseHeight)
        r1ControlPointView.center = CGPoint(x: maxRightX - rightPartWidth * 0.71, y: h)
        r2ControlPointView.center = CGPoint(x: maxRightX - (rightPartWidth * 0.44), y: h)
        r3ControlPointView.center = CGPoint(x: maxRightX, y: h)
    }
    
    @objc func updateShapeLayer() {
        shapeLayer.path = currentPath()
    }
    
    private func currentPath() -> CGPath {
        let width = bounds.width
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: bounds.maxY))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: l3ControlPointView.dg_center(usePresentationLayerIfPossible: animating).y))

        bezierPath.addCurve(to: l1ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint1: l3ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint2: l2ControlPointView.dg_center(usePresentationLayerIfPossible: animating))

        bezierPath.addCurve(to: r1ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint1: cControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint2: r1ControlPointView.dg_center(usePresentationLayerIfPossible: animating))

        bezierPath.addCurve(to: r3ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint1: r1ControlPointView.dg_center(usePresentationLayerIfPossible: animating), controlPoint2: r2ControlPointView.dg_center(usePresentationLayerIfPossible: animating))
        
        bezierPath.addLine(to: CGPoint(x: width, y:bounds.maxY))
        
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

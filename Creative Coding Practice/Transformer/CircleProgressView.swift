//
//  CircleProgressView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/04/16.
//

import UIKit

class CircularProgressView: UIView {
    var trackBorderWidth: CGFloat = 10
    var progressColor = UIColor.systemIndigo
    var percent: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    static let startDegrees: CGFloat = 315
    static let endDegrees: CGFloat = 225
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let startAngle: CGFloat = radians(of: CircularProgressView.startDegrees)
        let progressAngle = radians(of: CircularProgressView.startDegrees + (360 - CircularProgressView.startDegrees + CircularProgressView.endDegrees) * CGFloat(max(0.0, min(percent, 1.0))))

      
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(center.x, center.y) - trackBorderWidth / 2 - 20

        let arcLayer:CAShapeLayer = CAShapeLayer()
        let arcPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: progressAngle, clockwise: true)
        arcPath.close()
        arcPath.lineWidth = trackBorderWidth
        arcPath.lineCapStyle = .round
        arcLayer.strokeColor = UIColor.clear.cgColor
        arcLayer.path = arcPath.cgPath
        arcLayer.fillColor = progressColor.cgColor
        
        
        let straightLayer:CAShapeLayer = CAShapeLayer()
        straightLayer.frame = frame
        let straightPath = UIBezierPath()
        straightPath.move(to: CGPoint(x: center.x, y: 20))
        straightPath.addLine(to: CGPoint(x: center.x, y:40))
        straightPath.close()
        straightPath.lineWidth = trackBorderWidth
        straightPath.lineCapStyle = .round
        straightLayer.path = arcPath.cgPath
        straightLayer.strokeColor = UIColor.clear.cgColor
        straightLayer.fillColor = progressColor.cgColor
        layer.mask = arcLayer
        layer.addSublayer(straightLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func radians(of degrees: CGFloat) -> CGFloat {
        return degrees / 180 * .pi
    }
}

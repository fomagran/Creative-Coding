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

    // Adjust these to meet your needs. 90 degrees is the bottom of the circle
    static let startDegrees: CGFloat = 315
    static let endDegrees: CGFloat = 225

    override func draw(_ rect: CGRect) {
        let startAngle: CGFloat = radians(of: CircularProgressView.startDegrees)
        let progressAngle = radians(of: CircularProgressView.startDegrees + (360 - CircularProgressView.startDegrees + CircularProgressView.endDegrees) * CGFloat(max(0.0, min(percent, 1.0))))

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(center.x, center.y) - trackBorderWidth / 2 - 10

        let arcPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: progressAngle, clockwise: true)
        arcPath.lineWidth = trackBorderWidth
        arcPath.lineCapStyle = .round
        
        progressColor.set()
        arcPath.stroke()
        
        let straightPath = UIBezierPath()
        straightPath.move(to: CGPoint(x: center.x, y: 10))
        straightPath.addLine(to: CGPoint(x: center.x, y:50))
        straightPath.lineWidth = trackBorderWidth
        straightPath.lineCapStyle = .round
        
        progressColor.set()
        straightPath.stroke()
        
    }

    private func radians(of degrees: CGFloat) -> CGFloat {
        return degrees / 180 * .pi
    }
}

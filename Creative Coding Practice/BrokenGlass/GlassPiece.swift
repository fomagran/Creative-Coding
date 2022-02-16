//
//  GlassPiece.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/02/13.
//

import UIKit

class GlassPiece:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.withAlphaComponent(0.25).cgColor
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:0, y:frame.height))
        path.addLine(to: CGPoint(x:frame.width, y:0))
        path.close()
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }

    override var collisionBoundingPath: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:0, y:frame.height))
        path.addLine(to: CGPoint(x:frame.width, y:0))
        path.close()
        return path
    }
}

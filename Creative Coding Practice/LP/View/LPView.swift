//
//  LPView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit

protocol LPViewDelegate: AnyObject {
    func viewTapped(view: LPView)
}

class LPView: UIView {
    
    var LP:LP!
    weak var parent: LPViewDelegate?
    var centerView:UIView!
    var label = UILabel()
    
    init(frame: CGRect,lp:LP) {
        super.init(frame: frame)
        LP = lp
        label.text = lp.title
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize:frame.width/12)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.frame = CGRect(x:bounds.midX-frame.width/4, y: bounds.midY-frame.height/4, width: frame.width/2, height: frame.height/2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLP(sender: )))
        drawLP(lp.color)
        setCenterView(color:lp.color)
        addSubview(label)
        addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawLP(_ color:UIColor) {
        var radius = frame.width/2
        for i in 0..<10 {
            radius -= radius/20
            if i == 0 {
                drawCircle(radius, 0.0)
                continue
            }
            drawCircle(radius, 0.5)
        }
    }
    
    func setCenterView(color:UIColor) {
        centerView = UIView()
        centerView.frame = CGRect(x: bounds.midX - frame.height/4, y: bounds.midY - frame.height/4, width: frame.width/2, height: frame.height/2)
        centerView.backgroundColor = color
        centerView.layer.cornerRadius = centerView.frame.height/2
        addSubview(centerView)
    }
    
    func update(lp:LP) {
        self.centerView.backgroundColor = lp.color
        self.label.text = lp.title
    }
    
    @objc func tapLP(sender: UITapGestureRecognizer) {
        parent?.viewTapped(view: self)
    }
    
    func drawCircle(_ radius:CGFloat,_ lineWidth:CGFloat) {
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius:radius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        layer.addSublayer(circleLayer)
    }
}

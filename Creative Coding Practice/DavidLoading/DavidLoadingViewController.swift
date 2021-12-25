//
//  DavidLoadingViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/23.
//

import UIKit

class DavidLoadingViewController: UIViewController {
    
    let david:UIImageView = UIImageView(image: UIImage(named:"david.png"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pinkwall:UIImageView = UIImageView(image: UIImage(named:"pinkwall.png"))
        pinkwall.frame = CGRect(x: view.frame.midX-200, y: view.frame.midY-200, width: 400, height: 400)
        view.addSubview(pinkwall)
        david.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        view.addSubview(david)
        pinkwall.transform = pinkwall.transform.rotated(by: -.pi/4)
        david.transform = david.transform.rotated(by: .pi/4)
        
        
        let halfCross = (400*sqrt(2)/2)
        let davidX = view.frame.midX + 70
        david.center = CGPoint(x: davidX, y: pinkwall.center.y - halfCross)
        a(pinkwall: pinkwall)
    }
    
    func a(pinkwall:UIView) {
        drawArc(centerPoint:CGPoint(x:david.center.x+27.5, y: david.center.y+17.5), startPoint: david.center, angle:180)
        UIView.animate(withDuration: 2.5,delay:1,options: .curveEaseOut) {
            self.david.transform = self.david.transform.rotated(by: -.pi/4)
            pinkwall.transform = pinkwall.transform.rotated(by: -.pi/4)
        } completion: { _ in
            UIView.animate(withDuration: 1,delay: 0,options: .curveEaseOut) {
                self.david.transform = self.david.transform.rotated(by: -.pi/8)
                pinkwall.transform = pinkwall.transform.rotated(by: -.pi/8)
                self.david.center.x -= 35
                self.david.center.y -= 55
            } completion: { _ in
                UIView.animate(withDuration: 1,delay: 0,options: .curveEaseOut) {
                    self.david.transform = self.david.transform.rotated(by:.pi/8)
                    pinkwall.transform = pinkwall.transform.rotated(by: -.pi/8)
                    self.david.center.x -= 90
                    self.david.center.y -= 20
                } completion: { _ in
                    UIView.animate(withDuration: 1,delay: 0,options: .curveEaseOut) {
                        self.david.transform = self.david.transform.rotated(by:.pi/4)
                        let halfCross = (400*sqrt(2)/2)
                        let davidX = self.view.frame.midX + 70
                        self.david.center = CGPoint(x: davidX, y: pinkwall.center.y - halfCross)
                    } completion: { _ in
                        self.a(pinkwall: pinkwall)
                    }
                }
            }
        }
    }
    
    func drawArc(centerPoint: CGPoint, startPoint: CGPoint, angle: CGFloat) {
        let radius = getRadius(center: centerPoint, start: startPoint)
        let start = getStartAngle(center: centerPoint, point: startPoint, radius: radius)
        let end = getEndAngle(startAngle: start, angle: angle)

        let arcPath = UIBezierPath()
        arcPath.move(to: startPoint)
        arcPath.addArc(withCenter: centerPoint, radius: radius, startAngle: start, endAngle: end, clockwise: false)
        arcAnimation(path: arcPath)
    }
    
    func arcAnimation(path:UIBezierPath) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.repeatCount = 1
        animation.duration = 3.0
        david.layer.add(animation, forKey: "animate position along path")
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.david.layer.position = CGPoint(x: self.david.center.x + 55, y: self.david.center.y + 35)
        }
    }
    
    func getRadius(center: CGPoint, start: CGPoint) -> CGFloat {
        let xDist: CGFloat = start.x - center.x
        let yDist: CGFloat = start.y - center.y

        let radius: CGFloat = sqrt((xDist * xDist) + (yDist * yDist))

        return radius
    }
    
    func getStartAngle(center: CGPoint, point: CGPoint, radius: CGFloat) -> CGFloat {
        let origin = CGPoint(x: center.x + radius, y: center.y)

        let v1 = CGVector(dx: origin.x - center.x, dy: origin.y - center.y)
        let v2 = CGVector(dx: point.x - center.x, dy: point.y - center.y)

        let angle = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)

        return angle
    }
    
    func getEndAngle(startAngle: CGFloat, angle: CGFloat) -> CGFloat {
        return (angle * (.pi / 180)) + startAngle
    }
}

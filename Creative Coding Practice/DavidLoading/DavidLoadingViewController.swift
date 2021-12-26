//
//  DavidLoadingViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/23.
//

import UIKit
import AVFoundation

class DavidLoadingViewController: UIViewController {
    
    var player: AVAudioPlayer?
    let david:UIImageView = UIImageView(image: UIImage(named:"david.png"))
    let pinkwall:UIImageView = UIImageView(image: UIImage(named:"pinkwall.png"))
    var pinkwallHalfCross:Double = 0
    var davidHalfCross:Double = 0
    var pinkwallLength:CGFloat = 200
    var davidLength:CGFloat = 75
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        davidLoading()
    }
    
    func configure() {
        pinkwall.frame = CGRect(x: view.frame.midX-pinkwallLength/2, y: view.frame.midY-pinkwallLength/2, width: pinkwallLength, height: pinkwallLength)
        view.addSubview(pinkwall)
        david.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: davidLength, height: davidLength)
        view.addSubview(david)
        pinkwallHalfCross = pinkwall.frame.width*sqrt(2)/2
        davidHalfCross = david.frame.width*sqrt(2)/2
        pinkwall.transform = pinkwall.transform.rotated(by: -.pi/4)
        david.transform = david.transform.rotated(by: .pi/4)
        let davidX = view.frame.midX + davidHalfCross
        david.center = CGPoint(x: davidX, y: pinkwall.center.y - pinkwallHalfCross)
        setAVPlayer()
    }
    
    func setAVPlayer() {
        guard let url = Bundle.main.url(forResource: "davidLoading", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func davidLoading() {
        let pinkwall = pinkwall
        let david = david
        drawArc(centerPoint:CGPoint(x:david.center.x+davidLength/6, y:david.center.y + (pinkwallHalfCross-pinkwallLength/2 - davidLength/2)), startPoint: david.center, angle:180)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.player?.play()
        }
        UIView.animate(withDuration: 2,delay:0.4) {
            david.transform = david.transform.rotated(by: -.pi/4)
            pinkwall.transform = pinkwall.transform.rotated(by: -.pi/4)
        } completion: { _ in
            UIView.animate(withDuration: 1,delay: 0) {
                david.transform = david.transform.rotated(by: -.pi/8)
                pinkwall.transform = pinkwall.transform.rotated(by: -.pi/8)
                david.center.x -= self.davidHalfCross/2
                david.center.y -= (self.pinkwallHalfCross - self.pinkwallLength/2)/9*6
            } completion: { _ in
                UIView.animate(withDuration: 2,delay: 0) {
                    david.transform = david.transform.rotated(by:.pi/8)
                    pinkwall.transform = pinkwall.transform.rotated(by: -.pi/8)
                    david.center.x -= 90
                    david.center.y -= (self.pinkwallHalfCross - self.pinkwallLength/2)/9*3
                } completion: { _ in
                    UIView.animate(withDuration: 1,delay: 0) {
                        let davidX = self.view.frame.midX + self.davidHalfCross/7*2
                        david.center.x = davidX
                    } completion: { _ in
                        UIView.animate(withDuration: 1.4) {
                            david.transform = david.transform.rotated(by:.pi/4)
                            david.center.x += self.davidHalfCross/7*5
                            david.center.y = pinkwall.center.y - self.pinkwallHalfCross
                        } completion: { _ in
                            self.davidLoading()
                        }
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
        david.layer.removeAnimation(forKey: "animate position along path")
        UIView.animate(withDuration: 1.9) {
            self.david.layer.position = CGPoint(x: self.david.center.x + self.davidLength/3, y:self.pinkwall.center.y - self.pinkwallLength/2 - self.davidLength/2)
        }
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.repeatCount = 1
        animation.duration = 2
        david.layer.add(animation, forKey: "animate position along path")
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
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

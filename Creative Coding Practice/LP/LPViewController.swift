//
//  LPViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit
import AVFoundation

class LPViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    var bezier: QuadBezier!
    private var line = CAShapeLayer()
    
    let pathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
        
    var needle: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "needle.jpg")
        iv.frame = CGRect(origin: .zero, size: CGSize(width: 150, height: 150))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    var lpView = LPView()
    
    var niddleLineEnd = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lpView = LPView(frame: CGRect(x: view.bounds.midX-75, y: view.bounds.midY-75, width: 150, height: 150))
        view.addSubview(lpView)
        configure()
        setMusicPlayer()
    }
    
    func configure() {
        view.layer.addSublayer(pathLayer)
        view.addSubview(needle)
        setPanGesture()
        self.view.backgroundColor = .white
        niddleLineEnd = CGPoint(x: view.bounds.maxX, y: view.bounds.midY)
        bezier = buildCurvedPath()
        pathLayer.path = bezier.path.cgPath
        needle.center = bezier.point(at: 0.7)
        addLine(start:CGPoint(x: needle.center.x + 20, y: needle.center.y), end:niddleLineEnd)
    }
    
    func setMusicPlayer() {
        let url = Bundle.main.url(forResource:"기다린만큼 더", withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    private func setPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag(_:)))
        needle.addGestureRecognizer(panGesture)
    }
    
    private func addLine(start: CGPoint, end:CGPoint) {
        line.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.darkGray.cgColor
        line.lineWidth = 3
        view.layer.addSublayer(line)
    }
    
    //MARK:- Actions
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        updatePosition(location)
    }
    
    func buildCurvedPath() -> QuadBezier {
        let bounds = view.bounds
        let point1 = CGPoint(x: bounds.maxX, y: bounds.minY + 100)
        let point2 = CGPoint(x: bounds.maxX, y: bounds.maxY - 100)
        let controlPoint = CGPoint(x: bounds.maxX - 150, y: bounds.midY)
        let path = QuadBezier(point1: point1, point2: point2, controlPoint: controlPoint)
        return path
    }
    
    func updatePosition(_ position:CGPoint) {
        let location = position
        let t = (location.y - view.bounds.minY) / view.bounds.height
        needle.center.y = bezier.point(at: t).y
        needle.center.x = bezier.point(at: t).x - 20
        addLine(start:bezier.point(at: t), end:niddleLineEnd)
        touchLP(needle.center)
    }
    
    func touchLP(_ needle:CGPoint) {
        let distance = getTwoPointDistance(needle, lpView.center)
        if distance <= 150 {
            if lpView.layer.animation(forKey: "rotation") == nil {
                lpView.rotate()
                player?.play()
            }
        }else {
            lpView.layer.removeAllAnimations()
            player?.stop()
        }
    }
    
    private func getTwoPointDistance(_ point1:CGPoint,_ point2:CGPoint) -> CGFloat {
        let xDist:CGFloat = point2.x - point1.x
        let yDist:CGFloat = point2.y - point1.y
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotation")
    }
}

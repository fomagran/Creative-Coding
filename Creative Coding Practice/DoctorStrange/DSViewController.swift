//
//  DSViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/18.
//

import UIKit
import SpriteKit
import SceneKit

class DSViewController: UIViewController {
    
    let spark = SKView(withEmitter: "Spark")
    let square = SKView(withEmitter: "SquareSpark")
    let iv = UIImageView(image: UIImage(named:"sparkImage.png"))
    private var timer : Timer?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        square.frame = CGRect(x: view.bounds.midX-800, y: view.bounds.midY-800, width: 1600, height: 1600)
        square.contentMode = .scaleAspectFit
        let whiteView = setCenterCircle(view:square)
        square.addSubview(whiteView)
        view.addSubview(square)
        let imageView = UIImageView(image: UIImage(named: "폴고갱.jpeg"))
        imageView.frame = CGRect(x: view.bounds.midX-300, y: view.bounds.midY-300, width: 600, height: 600)
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.masksToBounds = true
        view.addSubview(imageView)
    }
    
    func setCenterCircle(view:UIView) -> UIView {
        let whiteView = UIView(frame: view.bounds)
        let maskLayer = CAShapeLayer() //create the mask layer

        // Set the radius to 1/3 of the screen width
        let radius : CGFloat = view.bounds.width/5

        // Create a path with the rectangle in it.
        let path = UIBezierPath(rect: view.bounds)
        // Put a circle path in the middle
        path.addArc(withCenter: whiteView.center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*Double.pi), clockwise: true)

        // Give the mask layer the path you just draw
        maskLayer.path = path.cgPath
        // Fill rule set to exclude intersected paths
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        // By now the mask is a rectangle with a circle cut out of it. Set the mask to the view and clip.
        whiteView.layer.mask = maskLayer
        whiteView.clipsToBounds = true

        whiteView.alpha = 1
        whiteView.backgroundColor = UIColor.black
        return whiteView
    }
    
    
    @objc func timerCallback() {
        showStars()
    }
    
    // MARK: - Actions
    func showStars() {
        particleEmitter.emitterCells = [starParticle]
        self.view.layer.addSublayer(particleEmitter)
    }
    
    @objc func handleTap(sender: UIPanGestureRecognizer) {
        
        particleEmitter.emitterPosition = sender.location(in: self.view)
        
        if sender.state == .ended {
               particleEmitter.lifetime = 0
           } else if sender.state == .began {
               showStars()
               particleEmitter.lifetime = 1.0
           }else if sender.state == .changed {
               spark.center = sender.location(in: self.view)
           }
       }
       
       // MARK: - Properties
       lazy var panGestureRecognizer:
           UIPanGestureRecognizer = {
               let gestureRecognizer = UIPanGestureRecognizer()
               gestureRecognizer
                   .addTarget(self, action: #selector(handleTap))
               return gestureRecognizer
       }()
       
       lazy var particleEmitter: CAEmitterLayer = {
           let emitter = CAEmitterLayer()
           emitter.emitterShape = .point
           emitter.renderMode = .additive
           return emitter
       }()
       
       let starParticle = StarParticle()
       
       // MARK: - UI Setup
       func setupUI() {
           self.view.backgroundColor = .black
           self.view.addGestureRecognizer(panGestureRecognizer)
       }
    
    func a() {
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = UIBezierPath(ovalIn:CGRect(x: view.frame.midX-350, y: view.frame.midY-400, width: 700, height: 800)).cgPath
        // I set this one to make the animation go smoothly along the path
        flightAnimation.calculationMode = CAAnimationCalculationMode.paced
        flightAnimation.duration = 3
        flightAnimation.rotationMode = CAAnimationRotationMode.rotateAuto
        flightAnimation.repeatCount = 1
        spark.layer.add(flightAnimation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.timer?.invalidate()
        }
    }
}

extension SKView {
 convenience init(withEmitter name: String) {
  self.init()

  self.frame = UIScreen.main.bounds
  backgroundColor = .clear

  let scene = SKScene(size: self.frame.size)
  scene.backgroundColor = .clear

  guard let emitter = SKEmitterNode(fileNamed: name + ".sks") else { return }
  emitter.name = name
  emitter.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)

  scene.addChild(emitter)
  presentScene(scene)
 }
}



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
    let zero = UIImageView(image: UIImage(named:"zero.png"))
    private var timer : Timer?
            
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        zero.frame = CGRect(x: view.bounds.midX-400, y: view.bounds.midY-400, width: 800, height: 800)
        square.frame = CGRect(x: view.bounds.midX-400, y: view.bounds.midY-400, width: 800, height: 800)
        view.addSubview(square)
        view.addSubview(zero)
        
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn) {
            self.zero.frame = CGRect(x: self.view.bounds.midX-self.view.frame.width, y: self.view.bounds.midY-self.view.frame.height, width: self.view.frame.width*2, height: self.view.frame.height*2)
            self.square.frame = CGRect(x: self.view.bounds.midX-self.view.frame.width, y: self.view.bounds.midY-self.view.frame.height, width: self.view.frame.width*2, height: self.view.frame.height*2)
        }

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



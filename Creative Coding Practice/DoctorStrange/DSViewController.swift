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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.addSubview(spark)
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
//               showStars()
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

//override func viewDidAppear(_ animated: Bool) {
//    let image = emitterImage
//    let side = min(view.bounds.width, view.bounds.height) * 0.8
//    let origin = CGPoint(x: view.bounds.midX - side / 2, y: view.bounds.midY - side / 2)
//    let center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
//    let size = CGSize(width: side, height: side)
//    let rect = CGRect(origin: origin, size: size)
//    let emitterLayer = CAEmitterLayer()
//    emitterLayer.emitterShape = CAEmitterLayerEmitterShape.rectangle
//    emitterLayer.emitterSize = rect.size
//    emitterLayer.emitterPosition = center
//
//    // define cells
//
//    let cell = CAEmitterCell()
//    cell.birthRate = Float(size.width * size.height / 10)
//    cell.lifetime = 1
//    cell.velocity = 10
//    cell.scale = 0.1
//    cell.scaleSpeed = -0.1
//    cell.emissionRange = .pi * 2
//    cell.contents = image.cgImage
//    emitterLayer.emitterCells = [cell]
//
//    // add the layer
//
//    view.layer.addSublayer(emitterLayer)
//
//    // mask the layer
//
//    let lineWidth = side / 8
//    let mask = CAShapeLayer()
//    mask.fillColor = UIColor.clear.cgColor
//    mask.strokeColor = UIColor.white.cgColor
//    mask.lineWidth = lineWidth
//    mask.path = UIBezierPath(arcCenter: center, radius: (side - lineWidth) / 2, startAngle: .pi / 4, endAngle: .pi * 7 / 4, clockwise: true).cgPath
//    emitterLayer.mask = mask
//}
//
//var emitterImage: UIImage {
//    let rect = CGRect(origin: .zero, size: CGSize(width: 10, height: 10))
//    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
//    #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).setFill()
//    UIBezierPath(arcCenter: CGPoint(x: rect.midX, y: rect.midY), radius: rect.midX, startAngle: 0, endAngle: .pi * 2, clockwise: true).fill()
//    let image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return image!
//}
//



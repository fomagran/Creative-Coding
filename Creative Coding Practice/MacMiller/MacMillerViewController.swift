//
//  MacMillerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/21.
//

import UIKit

class MacMillerViewController: UIViewController {
    
    // MARK: - Properties
    
    var iv:UIImageView!
    var glitchView:GlitchView!
    
    lazy var panGestureRecognizer:
    UIPanGestureRecognizer = {
        let gestureRecognizer = UIPanGestureRecognizer()
        gestureRecognizer
            .addTarget(self, action: #selector(handleDrag(sender:)))
        return gestureRecognizer
    }()
    
    lazy var particleEmitter: CAEmitterLayer = {
        let emitter = CAEmitterLayer()
        emitter.emitterShape = .point
        emitter.renderMode = .additive
        return emitter
    }()
    
    let starParticle = Particle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        glitchView = GlitchView(frame:CGRect(origin: .zero, size: CGSize(width: 200, height: 250)))
        view.addSubview(glitchView)
        glitchView.isHidden = true
        iv = UIImageView(image: UIImage(named: "macmiller.png"))
        iv.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 250))
        iv.center = view.center
        view.addSubview(iv)
        view.backgroundColor = .systemRed
        iv.isUserInteractionEnabled = true
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        iv.addGestureRecognizer(doubleTap)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handTap))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        iv.addGestureRecognizer(panGestureRecognizer)
        tap.require(toFail: doubleTap)
        
    }
    
    func springAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity:0.1, options:[]) {
            self.iv.layer.transform = CATransform3DMakeScale(1.5,1.5,1)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.iv.layer.transform = CATransform3DMakeScale(1,1,1)
            }
        }
    }
    
    func showGlitch() {
        glitchView.center = iv.center
        iv.isHidden = true
        glitchView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.glitchView.isHidden = true
            self.iv.isHidden = false
        }
    }
    
    // MARK: - Actions
    
    func showStars() {
        particleEmitter.emitterCells = [starParticle]
        self.view.layer.addSublayer(particleEmitter)
    }
    
    @objc func handleDrag(sender: UIPanGestureRecognizer) {
        iv.center = sender.location(in: self.view)
        particleEmitter.emitterPosition = sender.location(in: self.view)
        if sender.state == .ended {
            particleEmitter.lifetime = 0
        } else if sender.state == .began {
            showStars()
            particleEmitter.lifetime = 1.0
        }
    }
    
    @objc func handTap(sender:UITapGestureRecognizer) {
        springAnimation()
    }
    
    @objc func handDoubleTap(sender:UITapGestureRecognizer) {
       showGlitch()
    }
}



//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit

class WaterViewController: UIViewController {
    
    var isDrip: Bool = true
    private var dripWatertimer : Timer?
    private var rotateBottletimer : Timer?
    var bottle: Bottle = Bottle(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 200)))
    var dripWater: Water = Water(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 10)))
    var bottomWater: Water = Water(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
    var rotateAngle: Double = 0
    var waterLength: Int = 0
    var startButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 50))
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    var stopButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 50))
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        configure()
        view.addSubview(startButton)
        startButton.center = CGPoint(x: view.center.x - 100, y: view.center.y + 200)
        startButton.addTarget(self, action:#selector(start), for: .touchUpInside)
        view.addSubview(stopButton)
        stopButton.center = CGPoint(x: view.center.x + 100, y: view.center.y + 200)
        stopButton.addTarget(self, action:#selector(stop), for: .touchUpInside)
    }
    
    @objc func start() {
        startDripAnimation()
    }
    
    @objc func stop() {
        isDrip = false
    }
    
    func configure() {
        view.backgroundColor = .black
        bottle.center = view.center
        bottle.clipsToBounds = true
        view.addSubview(bottle)
        bottle.startAnimation(0.5)
        
        dripWater.center = CGPoint(x: view.center.x - 12.5 , y: view.center.y - 102.5)
        dripWater.layer.cornerRadius = 5
        
        bottomWater.center = CGPoint(x:0 , y: view.center.y - 102.5)
        bottomWater.layer.cornerRadius = 5
        
        view.addSubview(dripWater)
        view.addSubview(bottomWater)
    }
    
    func startRotateAnimation() {
        self.rotateBottletimer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.startRotate), userInfo: nil, repeats: true)
    }
    
    
    
    func startDripAnimation() {
        self.dripWatertimer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.startDrip), userInfo: nil, repeats: true)
    }
    
    func resetWaters() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.bottomWater.alpha = 0
        } completion: { _ in
            self.dripWater.center = CGPoint(x: self.view.center.x - 12.5 , y: self.view.center.y - 102.5)
            self.bottomWater.alpha = 1
            self.isDrip = true
            self.bottomWater.frame.size.height = 0
            self.bottomWater.center.y = self.view.center.y - 102.5
        }
    }
    
    @objc func startDrip() {
        if !isDrip {
            dripWater.frame.size.width += 1
        } else {
            isDrip = false
        }
        
        if dripWater.frame.size.width == 0 {
            self.resetWaters()
            dripWatertimer?.invalidate()
        }
        
        if dripWater.center.x < dripWater.frame.width/2 {
            dripWater.frame.size.width -= 1
            bottomWater.frame.size.height += 1
            bottomWater.center.y -= 0.5
        } else {
            dripWater.center.x -= 1
        }
    }
    
    @objc func startRotate() {
        self.bottle.rotate(degrees:rotateAngle)

    }
    
}

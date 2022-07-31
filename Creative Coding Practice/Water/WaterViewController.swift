//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit
import EasierPath

class WaterViewController: UIViewController {
    
    //The operation could not 어쩌고 오류난 이유 git local하고 remote하고 다를 때 억지로 local을 remote 브랜치로 reset시킬 때 해당 오류가 발생함
    
    var isDrip: Bool = true
    private var dripWatertimer : Timer?
    private var rotateBottletimer : Timer?

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
//        configure()
//        view.addSubview(startButton)
//        startButton.center = CGPoint(x: view.center.x - 100, y: view.center.y + 200)
//        startButton.addTarget(self, action:#selector(start), for: .touchUpInside)
//        view.addSubview(stopButton)
//        stopButton.center = CGPoint(x: view.center.x + 100, y: view.center.y + 200)
//        stopButton.addTarget(self, action:#selector(stop), for: .touchUpInside)
        
        let waterView: Water = Water(frame: CGRect(x: view.center.x-100, y: view.center.y-100, width: 200, height: 200))
        waterView.backgroundColor = .red
        view.addSubview(waterView)
        waterView.startFill(percent: 0.5)

//
//        let transparentView = makeTransparentView(parent:view)
//        view.addSubview(transparentView)
    }
    
    func makeTransparentView(parent:UIView) -> UIView {
        let backgroundView = UIView(frame: parent.frame)
        backgroundView.backgroundColor = .black
        
        let maskLayer = CAShapeLayer()
        let backgroundPath = UIBezierPath(rect: parent.frame)
        
        let transparentPath = BottleShape(view:view)
        
        backgroundPath.append(transparentPath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = backgroundPath.cgPath
        backgroundView.layer.mask = maskLayer
        return backgroundView
    }
  
    @objc func start() {
//        startDripAnimation()
        startRotateAnimation()
        
    }
    
    @objc func stop() {
//        isDrip = false
        stopRotateAnimation()
    }
    
    func configure() {
        view.backgroundColor = .black
        
        dripWater.center = CGPoint(x: view.center.x - 12.5 , y: view.center.y - 102.5)
        dripWater.layer.cornerRadius = 5
        
        bottomWater.center = CGPoint(x:0 , y: view.center.y - 102.5)
        bottomWater.layer.cornerRadius = 5
        
        view.addSubview(dripWater)
        view.addSubview(bottomWater)
    }
    
    func startRotateAnimation() {
        self.rotateBottletimer = Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(self.startRotate), userInfo: nil, repeats: true)
    }
    
    func startDripAnimation() {
        self.dripWatertimer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.startDrip), userInfo: nil, repeats: true)
    }
    
    func stopRotateAnimation() {
        rotateBottletimer?.invalidate()
    }
    
    func stopDripAnimation() {
        dripWatertimer?.invalidate()
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
        rotateAngle -= 1
        if rotateAngle < -90 {
            rotateBottletimer?.invalidate()
        }
//        self.bottle.rotate(degrees:rotateAngle)
    }
    
}

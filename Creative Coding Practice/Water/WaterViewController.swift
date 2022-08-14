//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit
import CoreMotion
import EasierPath

class WaterViewController: UIViewController {
    var isDrip: Bool = false
    private var dripWatertimer : Timer?
    private var waterColor: UIColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 1)

    var dripWater = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
    var bottomWater = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 10)))
    var waterLength: Int = 0
    var transparentView:UIView!
    lazy var waterView = Water(frame: CGRect(x: view.center.x-100, y: view.center.y-100, width: 200, height: 200))
    
    let motionManager = CMMotionManager()
    var gyroTimer: Timer!
    
    override func viewDidLoad() {
        let whiteView = UIView(frame: CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200))
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)

        view.addSubview(waterView)

        waterView.startFill(percent: 0.5)

        transparentView = makeTransparentView(parent:view)
        view.addSubview(transparentView)
        
        configure()
        
        manageMotion()
    }
    
    func manageMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) {
                (data, error) in
                if let data = data {
                    let rotation = atan2(data.gravity.x, data.gravity.y) - Double.pi
                    let pivot = Int(round(rotation*100)) + 312
                    
                    if pivot < 0 {
                        if pivot < -157 {
                            self.transparentView.transform = CGAffineTransformMakeRotation(CGFloat(-rotation))
                        }
                    } else {
                        if pivot > 157 {
                            self.transparentView.transform = CGAffineTransformMakeRotation(CGFloat(-rotation))
                        }
                    }
                }
            }
        }
    }
    
    func makeTransparentView(parent:UIView) -> UIView {
        let backgroundView = UIView(frame: parent.frame)
        backgroundView.backgroundColor = .black
        
        let maskLayer = CAShapeLayer()
        let backgroundPath = UIBezierPath(rect: backgroundView.frame)
        let transparentPath = BottleShape(view:backgroundView)
        
        backgroundPath.append(transparentPath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = backgroundPath.cgPath
        backgroundView.layer.mask = maskLayer
        return backgroundView
    }
    
    func configure() {
        view.backgroundColor = .black
        
        dripWater.layer.cornerRadius = 5
        bottomWater.layer.cornerRadius = 5
        
        resetWaters()
        
        dripWater.backgroundColor = waterColor
        bottomWater.backgroundColor = waterColor
        
        view.addSubview(dripWater)
        view.addSubview(bottomWater)
        
    }
    
    func startDripAnimation() {
        isDrip = true
        self.dripWatertimer = Timer.scheduledTimer(timeInterval:0.005, target: self, selector: #selector(self.startDrip), userInfo: nil, repeats: true)
    }
    
    func stopDripAnimation() {
        isDrip = false
        dripWatertimer?.invalidate()
    }
    
    func resetWaters() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.bottomWater.alpha = 0
        } completion: { _ in
            self.dripWater.center = CGPoint(x: self.waterView.frame.minX , y: self.view.center.y)
            self.bottomWater.alpha = 1
            self.isDrip = false
            self.bottomWater.frame.size.width = 0
            self.bottomWater.center = CGPoint(x: self.waterView.frame.minX, y: self.view.frame.height - 30)
        }
    }
    
    @objc func startDrip() {
        if isDrip {
            dripWater.frame.size.height += 1
        } else {
            if dripWater.frame.size.height == 0 {
                self.resetWaters()
                dripWatertimer?.invalidate()
            }
            
            dripWater.center.y += 1
        }
        
        if dripWater.frame.maxY > view.frame.height - 30 {
            dripWater.frame.size.height -= 1
            bottomWater.frame.size.width += 0.5
            bottomWater.center.x -= 0.25
        }
    }
}

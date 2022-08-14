//
//  GyroscopeViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/07/31.
//

import UIKit
import CoreMotion

class GyroscopeViewController: UIViewController {
    
    let manager = CMMotionManager()
    var timer: Timer!
    var imgView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.frame = CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
        imgView.image = UIImage(named: "skydoor.png")
        
        view.addSubview(imgView)
        
        manager.startAccelerometerUpdates()
        manager.startGyroUpdates()
        manager.startMagnetometerUpdates()
        manager.startDeviceMotionUpdates()
        
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.01
            manager.startDeviceMotionUpdates(to: OperationQueue.main) {
                (data, error) in
                if let data = data {
                    let rotation = atan2(data.gravity.x, data.gravity.y) - Double.pi
                    self.imgView.transform = CGAffineTransformMakeRotation(CGFloat(-rotation))
                }
            }
        }

    }

    
    private func degreesFromRadians(_ radians: Double) -> Double {
      return radians * 180 / .pi
    }
}

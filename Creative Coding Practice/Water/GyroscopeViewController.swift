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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.startGyroUpdates()
        manager.startAccelerometerUpdates()
        
        manager.deviceMotionUpdateInterval = 1
        
        manager.startDeviceMotionUpdates(to: .main) { (motion, error) in
            
            if let motion = motion?.attitude.quaternion {
              
                
                print(degreesFromRadians(yaw))

            }
        }
    }
    
    private func degreesFromRadians(_ radians: Double) -> Double {
      return radians * 180 / .pi
    }
}

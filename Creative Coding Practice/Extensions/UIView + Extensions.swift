//
//  UIView + Extensions.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/09.
//

import UIKit

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = NSNumber(value:Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotation")
    }
    
    func rotate(_ start:Double,_ degree:Double) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = NSNumber(value: start)
        rotation.toValue = NSNumber(value: degree)
        rotation.duration = 1
        rotation.repeatCount = 0
        rotation.fillMode = .forwards
        rotation.isRemovedOnCompletion = false
        self.layer.add(rotation, forKey: "rotation")
    }
}

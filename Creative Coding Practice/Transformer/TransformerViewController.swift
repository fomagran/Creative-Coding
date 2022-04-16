//
//  TransformerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/04/16.
//

import UIKit

class TransformerViewController: UIViewController {
    
    let gradient = CAGradientLayer()
     var gradientSet = [[CGColor]]()
     var currentGradient: Int = 0
     
     let gradientOne = UIColor(red: 50/255, green: 36/255, blue: 255/255, alpha: 1).cgColor
     let gradientTwo = UIColor(red: 34/255, green: 34/255, blue: 211/255, alpha: 1).cgColor
     let gradientThree = UIColor(red: 9/255, green: 31/255, blue: 146/255, alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gradientSet.append([gradientOne, gradientTwo])
             gradientSet.append([gradientTwo, gradientThree])
             gradientSet.append([gradientThree, gradientOne])
             
             
             gradient.frame = self.view.bounds
             gradient.colors = gradientSet[currentGradient]
             gradient.startPoint = CGPoint(x:0, y:0)
             gradient.endPoint = CGPoint(x:1, y:1)
             gradient.drawsAsynchronously = true
             self.view.layer.addSublayer(gradient)
             
             animateGradient()
    }
    
    func animateGradient() {
          if currentGradient < gradientSet.count - 1 {
              currentGradient += 1
          } else {
              currentGradient = 0
          }
          
          let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
          gradientChangeAnimation.duration = 5.0
          gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
          gradientChangeAnimation.isRemovedOnCompletion = false
          gradient.add(gradientChangeAnimation, forKey: "colorChange")
      }
  
}

extension TransformerViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}

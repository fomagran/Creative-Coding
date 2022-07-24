//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit

class WaterViewController: UIViewController {
    
    
    private var timer : Timer?
    var a:Double = 0
    var bottle: Bottle = Bottle(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 200)))
    var water: Water = Water(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 10)))
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        bottle.center = view.center
        bottle.clipsToBounds = true
        view.addSubview(bottle)
        bottle.startAnimation(0.5)
        
 
        
        water.center = CGPoint(x: view.center.x - 25 - 50/6 , y: view.center.y - 102.5)
        water.layer.cornerRadius = 5
        
        view.addSubview(water)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.timer = Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(self.fillWater), userInfo: nil, repeats: true)
        }
    }
    
    @objc func fillWater() {
        a += 1
//        self.bottle.rotate(degrees:a)
        water.frame.size.width += 1
        water.center.x -= 1
        
        if a > 100 {
            timer?.invalidate()
        }
    }
    
}

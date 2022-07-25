//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit

class WaterViewController: UIViewController {
    
    var b = false
    private var timer : Timer?
    var bottle: Bottle = Bottle(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 200)))
    var water1: Water = Water(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 10)))
    var water2: Water = Water(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        bottle.center = view.center
        bottle.clipsToBounds = true
        view.addSubview(bottle)
        bottle.startAnimation(0.5)
        
        water1.center = CGPoint(x: view.center.x - 12.5 , y: view.center.y - 102.5)
        water1.layer.cornerRadius = 5
        
        water2.center = CGPoint(x:0 , y: view.center.y - 102.5)
        water2.layer.cornerRadius = 5
        
        view.addSubview(water1)
        view.addSubview(water2)
        
        self.timer = Timer.scheduledTimer(timeInterval:0.01, target: self, selector: #selector(self.fillWater), userInfo: nil, repeats: true)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//
//        }
    }
    
    @objc func fillWater() {
//        self.bottle.rotate(degrees:a)
        if water1.frame.size.width < 50 && !b {
            water1.frame.size.width += 1
        } else {
            b = true
        }
        
        if water1.frame.size.width == 0 {
            water1.center = CGPoint(x: view.center.x - 12.5 , y: view.center.y - 102.5)
            timer?.invalidate()
        }
        
        if water1.center.x < water1.frame.width/2 {
            water1.frame.size.width -= 1
            water2.frame.size.height += 1
            water2.center.y -= 0.5
        } else {
            water1.center.x -= 1
        }
    }
    
}

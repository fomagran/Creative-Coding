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
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        bottle.center = view.center
        view.addSubview(bottle)
        bottle.startAnimation(0.5)
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
//            self.timer = Timer.scheduledTimer(timeInterval:0.1, target: self, selector: #selector(self.fillWater), userInfo: nil, repeats: true)
//        }
    }
    
    @objc func fillWater() {
        a += 1
        self.bottle.rotate(degrees:a)
        
        if a > 100 {
            timer?.invalidate()
        }
    }
    
}

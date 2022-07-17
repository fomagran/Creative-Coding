//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit

class WaterViewController: UIViewController {
    
    var bottle: Bottle = Bottle(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 200)))
    
    override func viewDidLoad() {
        bottle.center = view.center
        view.addSubview(bottle)
        bottle.startAnimation(0.75)
    }
    
}

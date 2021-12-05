//
//  WaveViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/01.
//

import UIKit

class WaveViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let w = WaveView(frame:CGRect(x:0, y: self.view.center.y, width: self.view.frame.width, height: 200))
        self.view.addSubview(w)
    }
}

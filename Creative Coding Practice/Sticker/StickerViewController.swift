//
//  StickerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/08/20.
//

import UIKit
import EasierPath

class StickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let v = UIView()
        v.frame.size = CGSize(width: 200, height: 100)
        v.center = view.center
        v.backgroundColor = .white
        
        let easierPath = EasierPath(view.center.x + 100 - 50, view.center.y - 50)
            .curve(to: .rightDown(50,20), .quad(.rightDown(30, 30)))
        
        let layer = easierPath.makeLayer(lineWidth: 1, lineColor: .black, fillColor: .red)
        
        let easierPath2 = EasierPath(view.center.x + 100 - 50, view.center.y - 50)
            .rightDown(50, 20)
            .up(20)
            .left(50)
        
        let layer2 = easierPath2.makeLayer(lineWidth: 1, lineColor: .black, fillColor: .black)
        
        view.addSubview(v)
        view.layer.addSublayer(layer)
        view.layer.addSublayer(layer2)
        
        
        
    }
}

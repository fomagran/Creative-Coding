//
//  StickerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/08/20.
//

import UIKit
import EasierPath

class StickerViewController: UIViewController {
    
    var timer: Timer!
    var w: CGFloat = 0
    var h: CGFloat = 0
    var z: CGFloat = 0
    var add: CGFloat = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(timeInterval:0.03, target: self, selector: #selector(test), userInfo: nil, repeats: true)
        
        let v = UIView()
        v.frame.size = CGSize(width: 200, height: 100)
        v.center = view.center
        v.backgroundColor = .white
        view.addSubview(v)
    }
    
    @objc func test() {
        if (view.layer.sublayers?.count ?? 0) > 1 {
            view.layer.sublayers?.removeLast()
            view.layer.sublayers?.removeLast()
        }
        w += 50/100 * add
        h += 20/100 * add
        z += 30/100 * add
        
        if w > 25 {
            add = -1
        }
        
        if add == -1 && w == 0 {
            add = 1
        }
        
        let easierPath = EasierPath(view.center.x + 100 - 50 + w*2, view.center.y - 50)
            .curve(to: .rightDown(50 - w*2,20 - h*2), .quad(.rightDown(30-z*2, 30-z*2)))
        
        let layer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .red)
        
        let easierPath2 = EasierPath(view.center.x + 100 - 50 + w, view.center.y - 50 - h)
            .rightDown(50 - w, 20 - h)
            .up(20)
            .left(50)
        
        let layer2 = easierPath2.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .black)
        
        view.layer.addSublayer(layer)
        view.layer.addSublayer(layer2)
    }
}

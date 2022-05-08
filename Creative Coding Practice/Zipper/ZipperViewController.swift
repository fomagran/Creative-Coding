//
//  ZipperViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/05/07.
//

import UIKit

class ZipperViewController: UIViewController {

    var zl:ZipperLine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        zl = ZipperLine(frame: CGRect(x:view.center.x - view.frame.width/2, y: view.center.y - view.frame.height/2, width: view.frame.width, height: view.frame.height))
        zl.backgroundColor = .blue
        view.addSubview(zl)
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func drag(_ sender:UIPanGestureRecognizer) {
        let y = sender.location(in: view).y
        zl.current = y/view.frame.height*4
    }
}

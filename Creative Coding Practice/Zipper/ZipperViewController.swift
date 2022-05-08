//
//  ZipperViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/05/07.
//

import UIKit

class ZipperViewController: UIViewController {

    var zl:ZipperLine!
    var zipper:Zipper!
    var zipperTop:ZipperTop!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        zl = ZipperLine(frame: CGRect(x:view.center.x - view.frame.width/2, y: view.center.y - view.frame.height/2, width: view.frame.width, height: view.frame.height))
        zl.backgroundColor = UIColor(displayP3Red: 246/255, green: 231/255, blue: 29/255, alpha: 1)
        view.addSubview(zl)
        
        zipper = Zipper(frame: CGRect(x: view.center.x-50, y: 20, width: 100, height: 100))
        zipper.backgroundColor = .clear
        view.addSubview(zipper)
        
        zipperTop = ZipperTop(frame: CGRect(x: view.center.x-5, y: 0, width: 10, height: 40))
        zipperTop.backgroundColor = .clear
        view.addSubview(zipperTop)
        
        zipper.addGestureRecognizer(panGesture)
        zipper.isUserInteractionEnabled = true
    }
    
    @objc func drag(_ sender:UIPanGestureRecognizer) {
        let location = sender.location(in: view).y
        zipperTop.center.y = location - 50
        zipper.center.y = location
        zl.current = (zipper.center.y-50)/view.frame.height*4
    }
}

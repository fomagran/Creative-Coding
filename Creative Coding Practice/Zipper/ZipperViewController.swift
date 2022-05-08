//
//  ZipperViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/05/07.
//

import UIKit

class ZipperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let zl:ZipperLine = ZipperLine(frame: CGRect(x:view.center.x - view.frame.width/2, y: view.center.y - 150, width: view.frame.width, height: 300))
        zl.backgroundColor = .blue
        view.addSubview(zl)
        
        func a(_ i:Double) {
            if Int(i) == 3 {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                zl.current = i
                a(i+0.05)
            }
        }
        
        a(0)
    }
}

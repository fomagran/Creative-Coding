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
        let zl:ZipperLine = ZipperLine(frame: CGRect(x:view.center.x - 150, y: view.center.y - 150, width: 100, height: 300))
        view.addSubview(zl)
    }
}

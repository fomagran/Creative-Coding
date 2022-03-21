//
//  BezierViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/20.
//

import UIKit

class BezierViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bezierView:BezierView = BezierView(frame:view.frame)
        bezierView.backgroundColor = .clear
        view.addSubview(bezierView)
    }
}

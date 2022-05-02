//
//  BezierViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/20.
//

import UIKit

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let testView:TestView = TestView(frame:view.frame)
        testView.backgroundColor = .white
        view.addSubview(testView)
    }
}

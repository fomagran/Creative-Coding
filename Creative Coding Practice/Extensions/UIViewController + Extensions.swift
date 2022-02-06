//
//  UIViewController + Extensions.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/02/06.
//

import Foundation
import UIKit

extension UIViewController {
    func addLine(line:CAShapeLayer,start: CGPoint, end:CGPoint) {
        line.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.darkGray.cgColor
        line.lineWidth = 1
        view.layer.addSublayer(line)
    }
}

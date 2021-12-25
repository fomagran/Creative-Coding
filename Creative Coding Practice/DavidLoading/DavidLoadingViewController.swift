//
//  DavidLoadingViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/23.
//

import UIKit

class DavidLoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pinkwall:UIImageView = UIImageView(image: UIImage(named:"pinkwall.png"))
        let david:UIImageView = UIImageView(image: UIImage(named:"david.png"))
        pinkwall.frame = CGRect(x: view.frame.midX-200, y: view.frame.midY-200, width: 400, height: 400)
        view.addSubview(pinkwall)
        david.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        view.addSubview(david)
        pinkwall.transform = pinkwall.transform.rotated(by: -.pi/4)
        david.transform = david.transform.rotated(by: .pi/4)
        let halfCross = (400*sqrt(2)/2)
        let davidX = view.frame.midX + 70
        david.center = CGPoint(x: davidX, y: pinkwall.center.y - halfCross)
    
        UIView.animate(withDuration: 1.4, delay:0, options: .curveEaseOut) {
            david.center.y += 35
        }

        UIView.animate(withDuration: 3,delay:0,options: .curveEaseOut) {
            david.center.x += 130
            david.transform = david.transform.rotated(by: -.pi/4)
            pinkwall.transform = pinkwall.transform.rotated(by: -.pi/4)
        }

        UIView.animate(withDuration: 2,delay: 2.8,options: .curveEaseOut) {
            david.transform = david.transform.rotated(by: -.pi/8)
            pinkwall.transform = pinkwall.transform.rotated(by: -.pi/8)
            david.center.x -= 100
            david.center.y -= 55
        }
        
        UIView.animate(withDuration: 2,delay: 4.8,options: .curveEaseOut) {
            david.transform = david.transform.rotated(by:.pi/8)
            pinkwall.transform = pinkwall.transform.rotated(by: -.pi/8)
            david.center.x -= 100
            david.center.y -= 20
        }
        
    }
}

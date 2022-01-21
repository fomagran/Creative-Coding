//
//  MacMillerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/21.
//

import UIKit

class MacMillerViewController: UIViewController {
    
    var iv:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iv = UIImageView(image: UIImage(named: "macmiller.png"))
        iv.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 250))
        iv.center = view.center
        view.addSubview(iv)
        view.backgroundColor = .systemRed
        animation()
        
    }
    
    func animation() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options:[]) {
            self.iv.layer.transform = CATransform3DMakeScale(1.5,1.5,1)
        } completion: { _ in
            UIView.animate(withDuration: 1) {
                self.iv.layer.transform = CATransform3DMakeScale(1,1,1)
            } completion: { _ in
                self.animation()
            }
        }
    }
}



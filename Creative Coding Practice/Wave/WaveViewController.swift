//
//  WaveViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/01.
//

import UIKit

class WaveViewController: UIViewController {
    
    var w:WaveView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        super.viewDidLoad()
        w = WaveView(frame:CGRect(x:0, y: self.view.center.y-200, width: self.view.frame.width, height: 400))
        
        self.view.addSubview(w)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        w.addGestureRecognizer(tapGesture)
        let imageView = UIImageView()
        imageView.frame = CGRect(x:self.view.center.x-100, y: self.view.center.y-100, width: 200, height: 200)
        imageView.image = UIImage(named: "fomagran.png")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        self.view.addSubview(imageView)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        w.handleTimer()
    }
    
    
}

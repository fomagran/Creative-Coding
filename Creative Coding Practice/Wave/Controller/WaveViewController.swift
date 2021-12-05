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
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.view.backgroundColor = UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        w = WaveView(frame:CGRect(x:self.view.center.x-150, y: self.view.center.y-130, width: 300, height: 260))
        self.view.addSubview(w)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWave(sender:)))
        w.addGestureRecognizer(tapGesture)
        addImageView()
    }
    
    private func addImageView() {
        let imageView = UIImageView()
        imageView.frame = CGRect(x:self.view.center.x-190, y: self.view.center.y-200, width: 380, height: 400)
        imageView.image = UIImage(named: "fomagran.png")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 200
        imageView.layer.masksToBounds = true
        self.view.addSubview(imageView)
    }
    
    @objc func didTapWave(sender: UITapGestureRecognizer) {
        w.changeColor()
    }
}

//
//  AViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/29.
//

import UIKit

class AViewController: UIViewController {
    
    var t:ThreeDCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        t = ThreeDCardView(frame:view.frame)
        t.dataSource = self
        view.addSubview(t)
        t.backgroundColor = .systemRed
    }
}

extension AViewController:ThreeDCardDataSource {
    func setCardImages() -> [UIImage] {
        let images:[UIImage] = [UIImage(named: "살바도르달리.jpeg")!,UIImage(named: "폴고갱.jpeg")!,UIImage(named: "반고흐.png")!,UIImage(named: "마르셀 뒤샹.png")!]
        return images
    }
}

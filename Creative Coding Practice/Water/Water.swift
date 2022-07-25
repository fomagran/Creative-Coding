//
//  Water.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/07/24.
//

import UIKit

class Water: UIView {
    
    private var waterColor: UIColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = waterColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

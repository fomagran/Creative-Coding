//
//  KeyboardCharacter.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/04/24.
//

import UIKit

class KeyboardCharacter: UIButton {

    init(frame: CGRect,character:String) {
        super.init(frame: frame)
        backgroundColor = UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 0/255)
        setTitle(character, for: .normal)
        setTitleColor(UIColor(displayP3Red: 245/255, green: 241/255, blue: 80/255, alpha:0), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        layer.shadowColor = UIColor(displayP3Red: 255/255, green: 251/255, blue: 28/255, alpha: 1).cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

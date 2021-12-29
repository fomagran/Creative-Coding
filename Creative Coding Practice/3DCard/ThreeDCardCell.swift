//
//  ThreeDCardView.swift
//  Swift ArtCode
//
//  Created by Fomagran on 2021/12/16.
//

import UIKit

class ThreeDCardCell: UIView {
    
    var card:Card
        
    init(frame: CGRect,card:Card) {
        self.card = card
        super.init(frame: frame)
        configure(image: card.image)
        setGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image:UIImage) {
        let imageLayer = CAShapeLayer()
        let reflectionLayer = CAShapeLayer()
        addSubLayer(imageLayer,image, CGRect(x: 0, y: 0, width: frame.width, height: frame.height/5*4), false)
        addSubLayer(reflectionLayer, image, CGRect(x: 0, y: frame.height/5*4+1, width: frame.width, height: frame.height/5*1), true)
    }
    
    private func addSubLayer(_ layer:CAShapeLayer,_ image:UIImage,_ frame:CGRect,_ isRefelction:Bool) {
        var img = image
        if isRefelction {
            layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            img = image.flipImageVertically()!
        }
        layer.contents = img.cgImage
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.frame = frame
        self.layer.addSublayer(layer)
    }
    
    private func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(1).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.75)
        gradientLayer.endPoint = CGPoint(x:0.0,y:1.0)
        layer.mask = gradientLayer
    }
}

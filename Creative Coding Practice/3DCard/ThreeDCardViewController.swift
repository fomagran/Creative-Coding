//
//  3DCardViewController.swift
//  Swift ArtCode
//
//  Created by Fomagran on 2021/12/16.
//

import UIKit

class ThreeDCardViewController: UIViewController {
    
    
    var cardViews:[ThreeDCardCell] = []
    var current:Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDrag()
    }

    init(cards:[Card]) {
        self.cardViews = cards.map{ThreeDCardCell(frame: $0.frame,card:$0)}
        current = cards.first
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func moveRight() {
        for cardView in cardViews {
            cardView.card.index -= 1
        }
        if current.index == cardViews.count-1 {
            return
        }
        for i in 0..<cardViews.count {
            let cardView = cardViews[i]
            let card = cardView.card
            if i == current.index {
                rightFlipAnimation(card:cardView)
            }else {
                UIView.animate(withDuration: 0.5, delay: 0, options:.curveEaseIn, animations: {
                    let rotation = CATransform3DMakeRotation(0.05, 0, 1, 0)
                    self.cardViews[i].card.scale *= 1.5
                    let cardScale = self.cardViews[i].card.scale
                    let scale = CATransform3DMakeScale(cardScale,cardScale,1)
                    cardView.layer.transform = CATransform3DConcat(rotation,scale)
                    if i > self.current.index {
                        let frame = self.cardViews[card.index].frame
                        cardView.center = CGPoint(x:frame.midX, y:frame.midY)
                    }
                })
            }
        }
        current = cardViews[current.index+1].card
    }
    
    func moveLeft() {
        for cardView in cardViews {
            cardView.card.index += 1
        }
        if current.index == 0 {
            return
        }
        for i in 0..<cardViews.count{
            let cardView = cardViews[i]
            let card = cardView.card
            if i == current.index-1 {
               leftFlipAnimation(card: cardView)
            }else {
                UIView.animate(withDuration: 0.5, delay: 0, options:.curveEaseIn, animations: {
                    CATransform3DMakeTranslation(0, 1, 0)
                    let rotation = CATransform3DMakeRotation(0.05, 0, 1, 0)
                    self.cardViews[i].card.scale *= 2/3
                    let cardScale = self.cardViews[i].card.scale
                    let scale = CATransform3DMakeScale(cardScale,cardScale,1)
                    cardView.layer.transform = CATransform3DConcat(rotation,scale)
                    if i > self.current.index-1 {
                        let frame = self.cardViews[card.index].frame
                        cardView.center = CGPoint(x:frame.midX, y:frame.midY)
                    }
                })
            }
        }
        current = cardViews[current.index-1].card
    }
    
    func leftFlipAnimation(card:UIView) {
        card.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options:.curveEaseIn, animations: {
            let rotation = CATransform3DMakeRotation(0.05, 0, 1, 0)
            self.cardViews[self.current.index].card.scale *= 2/3
            let cardScale = self.cardViews[self.current.index].card.scale
            let scale = CATransform3DMakeScale(cardScale,cardScale,1)
            card.layer.transform = CATransform3DConcat(rotation, scale)
            card.center.x = self.cardViews[0].card.frame.midX
        })
    }
    
    func rightFlipAnimation(card:UIView) {
        UIView.animate(withDuration: 1, delay: 0, options:.curveEaseOut, animations: {
            let rotation = CATransform3DMakeRotation(0.5, 0, 1, 0)
            self.cardViews[self.current.index].card.scale *= 1.5
            let cardScale = self.cardViews[self.current.index].card.scale
            let scale = CATransform3DMakeScale(cardScale,cardScale,1)
            card.layer.transform = CATransform3DConcat(rotation, scale)
            card.center.x = self.view.frame.maxX
        }) { _ in
            card.isHidden = true
        }
    }
    
    func setDrag() {
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
        leftSwipeRecognizer.numberOfTouchesRequired = 1
        leftSwipeRecognizer.direction = .left
        view.addGestureRecognizer(leftSwipeRecognizer)
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        rightSwipeRecognizer.numberOfTouchesRequired = 1
        rightSwipeRecognizer.direction = .right
        view.addGestureRecognizer(rightSwipeRecognizer)
    }
    
    @objc private func leftSwiped(recognizer: UISwipeGestureRecognizer) {
        moveLeft()
    }
    
    @objc private func rightSwiped(recognizer: UISwipeGestureRecognizer) {
        moveRight()
    }
    
    func setTransform(bgView:UIView) {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        let transformLayer = CATransformLayer()
        transformLayer.transform = perspective
        transformLayer.position = CGPoint(x: 0, y:0)
        transformLayer.addSublayer(bgView.layer)
        view.layer.addSublayer(transformLayer)
        bgView.layer.transform = CATransform3DMakeRotation(0.05, 0, 1, 0)
    }
}

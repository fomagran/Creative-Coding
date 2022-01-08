//
//  ThreeDCardView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/29.
//

import UIKit

class ThreeDCardView:UIView {

    //MARK:- Properties
    
    var positions:[CGPoint] = []
    var cardCells:[ThreeDCardCell] = []
    var current:Card!
    weak var dataSource:ThreeDCardDataSource? {
        didSet {
            updateCards()
        }
    }

    //MARK:- Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setDrag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Functions

    func updateCards() {
        let images = dataSource?.setCardImages() ?? []
        let cards = makeCards(images: images)
        for card in cards {
            let cell = ThreeDCardCell(frame: card.frame, card:card)
            setTransform(cell)
            cardCells.append(cell)
        }
        current = cardCells.first!.card
    }

    func makeCards(images:[UIImage]) -> [Card] {
        var cards:[Card] = []
        var prev:Card?
        for (i,image) in images.enumerated() {
            let card:Card = Card(index: i, image: image, frame:frame, prev: prev)
            positions.append(card.point)
            cards.append(card)
            prev = card
        }
        return cards
    }
    
    func setDrag() {
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
        leftSwipeRecognizer.numberOfTouchesRequired = 1
        leftSwipeRecognizer.direction = .left
        addGestureRecognizer(leftSwipeRecognizer)
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
        rightSwipeRecognizer.numberOfTouchesRequired = 1
        rightSwipeRecognizer.direction = .right
        addGestureRecognizer(rightSwipeRecognizer)
    }

    func setTransform(_ cell:UIView) {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        let transformLayer = CATransformLayer()
        transformLayer.transform = perspective
        transformLayer.position = CGPoint(x: 0, y:0)
        transformLayer.addSublayer(cell.layer)
        layer.addSublayer(transformLayer)
        cell.layer.transform = CATransform3DMakeRotation(0.05, 0, 1, 0)
    }
    
    func moveRight() {
        if current.index == cardCells.count-1 {
            return
        }
        for i in 0..<cardCells.count {
            let cell = cardCells[i]
            if current.index == i {
                rightFlipAnimation(cell)
            }else {
                UIView.animate(withDuration: 0.5, delay: 0, options:.curveEaseIn, animations: {
                    let rotation = CATransform3DMakeRotation(0.05, 0, 1, 0)
                    self.cardCells[i].card.scale *= 1.5
                    let cardScale = self.cardCells[i].card.scale
                    let scale = CATransform3DMakeScale(cardScale,cardScale,1)
                    cell.layer.transform = CATransform3DConcat(rotation,scale)
                    if i > self.current.index {
                        let point = self.positions[i-self.current.index-1]
                        cell.center = CGPoint(x: point.x+cell.frame.width/2, y: point.y+cell.frame.height/2)
                    }
                })
            }
        }
        current = cardCells[current.index+1].card
    }
    
    func moveLeft() {
        if current.index == 0 {
            return
        }
        for i in 0..<cardCells.count{
            let cell = cardCells[i]
            if i == current.index-1 {
               leftFlipAnimation(card: cell)
            }else {
                UIView.animate(withDuration: 0.5, delay: 0, options:.curveEaseIn, animations: {
                    CATransform3DMakeTranslation(0, 1, 0)
                    let rotation = CATransform3DMakeRotation(0.05, 0, 1, 0)
                    self.cardCells[i].card.scale *= 2/3
                    let cardScale = self.cardCells[i].card.scale
                    let scale = CATransform3DMakeScale(cardScale,cardScale,1)
                    cell.layer.transform = CATransform3DConcat(rotation,scale)
                    if i > self.current.index-1 {
                        let point = self.positions[i-self.current.index+1]
                        cell.center = CGPoint(x: point.x+cell.frame.width/2, y: point.y+cell.frame.height/2)
                    }
                })
            }
        }
        current = cardCells[current.index-1].card
    }

    func leftFlipAnimation(card:UIView) {
        card.isHidden = false
        UIView.animate(withDuration: 1, delay: 0, options:.curveEaseIn, animations: {
            let rotation = CATransform3DMakeRotation(0.05, 0, 1, 0)
            self.cardCells[self.current.index-1].card.scale *= 2/3
            let cardScale = self.cardCells[self.current.index-1].card.scale
            let scale = CATransform3DMakeScale(cardScale,cardScale,1)
            card.layer.transform = CATransform3DConcat(rotation, scale)
            card.center.x = self.positions[0].x + card.frame.width/2
        })
    }

    func rightFlipAnimation(_ card:ThreeDCardCell) {
        UIView.animate(withDuration: 1, delay: 0, options:.curveEaseOut, animations: {
            let rotation = CATransform3DMakeRotation(0.5, 0, 1, 0)
            self.cardCells[self.current.index].card.scale *= 1.5
            let cardScale = self.cardCells[self.current.index].card.scale
            let scale = CATransform3DMakeScale(cardScale,cardScale,1)
            card.layer.transform = CATransform3DConcat(rotation, scale)
            card.center.x = self.frame.maxX
        }) { _ in
            card.isHidden = true
        }
    }
    
    //MARK:- @objc Functions

    @objc private func leftSwiped(recognizer: UISwipeGestureRecognizer) {
        moveLeft()
    }

    @objc private func rightSwiped(recognizer: UISwipeGestureRecognizer) {
        moveRight()
    }
}

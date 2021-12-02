//
//  WaveView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/02.
//
import UIKit

@IBDesignable
class WavyView: UIView {

    private weak var displayLink: CADisplayLink?
    private var startTime: CFTimeInterval = 0
    private let maxAmplitude: CGFloat = 0.1
    private let maxTidalVariation: CGFloat = 0.1
    private let amplitudeOffset = CGFloat.random(in: -0.5 ... 0.5)
    private let amplitudeChangeSpeedFactor = CGFloat.random(in: 4 ... 8)

    private let defaultTidalHeight: CGFloat = 0.50
    private let saveSpeedFactor = CGFloat.random(in: 4 ... 8)

    private lazy var background: UIView = {
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layer.addSublayer(shapeLayer)
        return background
    }()

    private let shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.fillColor = UIColor.systemBlue.cgColor
        return shapeLayer
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        if newSuperview == nil {
            displayLink?.invalidate()
        }
   }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        shapeLayer.path = wave(at: 0)?.cgPath
    }
}

private extension WavyView {

    func configure() {
        addSubview(background)

        startDisplayLink()
    }

    func wave(at elapsed: Double) -> UIBezierPath? {
        guard bounds.width > 0, bounds.height > 0 else { return nil }

        func f(_ x: CGFloat) -> CGFloat {
            let elapsed = CGFloat(elapsed)
            let amplitude = maxAmplitude * abs(fmod(elapsed / 2, 3) - 1.5)
            let variation = sin((elapsed + amplitudeOffset) / amplitudeChangeSpeedFactor) * maxTidalVariation
            let value = sin((elapsed / saveSpeedFactor + x) * 4 * .pi)
            return value * amplitude / 2 * bounds.height + (defaultTidalHeight + variation) * bounds.height
        }

        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))

        let count = Int(bounds.width / 10)

        for step in 0 ... count {
            let dataPoint = CGFloat(step) / CGFloat(count)
            let x = dataPoint * bounds.width + bounds.minX
            let y = bounds.maxY - f(dataPoint)
            let point = CGPoint(x: x, y: y)
            path.addLine(to: point)
        }
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.close()
        return path
    }

    func startDisplayLink() {
        startTime = CACurrentMediaTime()
        displayLink?.invalidate()
        let displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink(_:)))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }

    func stopDisplayLink() {
        displayLink?.invalidate()
    }

    @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
        let elapsed = CACurrentMediaTime() - startTime
        shapeLayer.path = wave(at: elapsed)?.cgPath
    }
}

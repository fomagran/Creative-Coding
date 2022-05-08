import UIKit

class ZipperLine:UIView {
    var h:CGFloat = 0
    var w:CGFloat = 0
    var current: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        h = (rect.height-100)/20
        w = 25
        var x:CGFloat = rect.width/2
        var y:CGFloat = 0
        
        for i in 0..<20 {
            var line:UIBezierPath = UIBezierPath()
            if current*100-y > 0 {
                x = i%2 == 0 ? rect.width/2 + (y - current*100) : rect.width/2 - (y - current*100)
                line = i%2 == 1 ? creatLeftLine(x-w/4, y) : creatRightLine(x+w/4, y)
                line.rotateAroundCenter(angle:i%2 == 0 ? (y/100-current)/3 : -(y/100-current)/3)
            }else {
                x = rect.width/2
                line = i%2 == 1 ? creatLeftLine(x-w/4, y) : creatRightLine(x+w/4, y)
            }
            UIColor.white.setFill()
            UIColor.clear.setStroke()
            line.fill()
            line.stroke()
            line.close()
            y += h+5
        }
    }
    
    func creatLeftLine(_ x:CGFloat,_ y:CGFloat) -> UIBezierPath {
        let lineDot:UIBezierPath = UIBezierPath()
        lineDot.move(to: CGPoint(x: x,y:y))
        lineDot.addLine(to: CGPoint(x:x,y: y+h))
        lineDot.addLine(to: CGPoint(x:x+w,y:y+h))
        lineDot.addQuadCurve(to: CGPoint(x:x+w,y:y), controlPoint: CGPoint(x:x+w*1.2,y:y+h/2))
        lineDot.addLine(to: CGPoint(x:x,y:y))
        return lineDot
    }
    
    func creatRightLine(_ x:CGFloat,_ y:CGFloat) -> UIBezierPath {
        let lineDot:UIBezierPath = UIBezierPath()
        lineDot.move(to: CGPoint(x: x,y:y))
        lineDot.addLine(to: CGPoint(x:x-w,y:y))
        lineDot.addQuadCurve(to: CGPoint(x:x-w,y:y+h), controlPoint: CGPoint(x:x-w*1.2,y:y+h/2))
        lineDot.addLine(to: CGPoint(x:x,y: y+h))
        lineDot.addLine(to: CGPoint(x:x,y:y))
        return lineDot
    }
}

extension UIBezierPath
{
    func rotateAroundCenter(angle: CGFloat)
    {
        let center = CGPoint(x: bounds.minX+bounds.size.width/2, y: bounds.minY+bounds.size.height/2)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: angle)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        self.apply(transform)
    }
}

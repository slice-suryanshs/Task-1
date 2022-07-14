import UIKit

class LineView: UIView {
    
    var pattern: [CGFloat] = [1.0, 0.0]
    
    private func linePath () -> UIBezierPath {
        let pointA = CGPoint(x: 0, y: bounds.midY)
        let pointB = CGPoint(x: bounds.width, y: bounds.midY)
        let path = UIBezierPath()
        path.move(to: pointA)
        path.addLine(to: pointB)
        path.lineWidth = bounds.height
        path.setLineDash(pattern, count: 2, phase: 0.0)
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor(red: 0.89, green: 0.914, blue: 0.937, alpha: 1).set()
        linePath().stroke()
    }
}

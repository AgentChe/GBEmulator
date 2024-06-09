//
//  RatingView.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 09.06.2024.
//

import UIKit

final class RatingView: UIView {
    var rating: Float = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private let maxRating = 5
    private let starFillColors: (filled: UIColor, unfilled: UIColor) = (
        UIColor(integralRed: 255, green: 156, blue: 40),
        UIColor(integralRed: 255, green: 156, blue: 40, alpha: 0.5)
    )

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let starWidth = rect.width / CGFloat(maxRating)
        let starHeight = rect.height
        
        for i in 0..<maxRating {
            let starRect = CGRect(x: CGFloat(i) * starWidth, y: 0, width: starWidth, height: starHeight)
            let starPath = self.starPath(in: starRect)
            context?.addPath(starPath.cgPath)
            
            let starRating = min(rating - Float(i), 1)
            if starRating > 0 {
                context?.setFillColor(starFillColors.filled.cgColor)
                context?.clip()
                context?.fill(CGRect(x: starRect.minX, y: starRect.minY, width: starRect.width * CGFloat(starRating), height: starRect.height))
                context?.resetClip()
            }
            
            context?.setStrokeColor(starFillColors.unfilled.cgColor)
            context?.setLineWidth(1.0)
            context?.addPath(starPath.cgPath)
            context?.strokePath()
        }
    }
}

// MARK: Private
private extension RatingView {
    func starPath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let points = 5
        
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.5

        let center = CGPoint(x: rect.midX, y: rect.midY)

        var angle = -CGFloat.pi / 2

        for i in 0..<points * 2 {
            let radius = i % 2 == 0 ? outerRadius : innerRadius
            let pointX = center.x + radius * cos(angle)
            let pointY = center.y + radius * sin(angle)
            let point = CGPoint(x: pointX, y: pointY)
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }

            angle += CGFloat.pi / CGFloat(points)
        }

        path.close()
        return path
    }

}

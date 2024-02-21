//
//  CircularProgressView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 21/02/24.
//

import UIKit

final class CircularProgressView: UIView {
    
    // MARK: - Properties
    
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private var rounded: Bool
    private var filled: Bool
    private let lineWidth: CGFloat
    private var progress: Float
    
    var timeToFill = 3.43
    
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        progress = 0
        rounded = true
        filled = false
        lineWidth = 15
        super.init(frame: frame)
        createProgressView()
    }
    
    required init?(coder: NSCoder) {
        progress = 0
        rounded = true
        filled = false
        lineWidth = 15
        super.init(coder: coder)
        createProgressView()
    }
    
    init(frame: CGRect, lineWidth: CGFloat?, rounded: Bool) {
        progress = 0
        self.lineWidth = lineWidth ?? 15
        self.rounded = rounded
        self.filled = lineWidth == nil
        super.init(frame: frame)
        createProgressView()
    }
    
    // MARK: - Public Methods
    
    func setProgress(duration: TimeInterval = 3, to newProgress: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = newProgress
        
        progressLayer.strokeEnd = CGFloat(newProgress)
        progressLayer.add(animation, forKey: "animationProgress")
    }
    
    // MARK: - Private Methods
    
    private func createProgressView() {
        backgroundColor = .clear
        layer.cornerRadius = frame.size.width / 2
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: frame.width / 2,
            startAngle: CGFloat(-0.5 * .pi),
            endAngle: CGFloat(1.5 * .pi),
            clockwise: true
        )
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.blue.cgColor
        trackLayer.fillColor = .none
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = filled ? frame.width : lineWidth
        trackLayer.strokeEnd = 1
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = .none
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = filled ? frame.width : lineWidth
        progressLayer.strokeEnd = 0
        progressLayer.lineCap = rounded ? .round : .butt
        
        layer.addSublayer(progressLayer)
    }
}

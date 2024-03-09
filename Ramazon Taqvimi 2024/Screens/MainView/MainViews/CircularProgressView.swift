//
//  CircularProgressView.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 05/03/24.
//

import UIKit

protocol ProgressVieDelegate: AnyObject {
    func didEndProgress()
}

class CircularProgressView: UIView {
    
    // MARK: - Properties
    
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private var rounded: Bool
    private var filled: Bool
    private let lineWidth: CGFloat
    private var progress: Float
    private var totalTime: TimeInterval = 0
    private var remainingTime: TimeInterval = 0
    
    weak var delegate: ProgressVieDelegate?
    
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeEnd = CGFloat(progress)
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
//                label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let openAndCloseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    // MARK: - Private Methods
    
    private func createProgressView() {
        backgroundColor = .clear
        layer.cornerRadius = frame.size.width / 2
        
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
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
        
        addSubview(timeLabel)
        
        timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        
        addSubview(openAndCloseLabel)
        
        openAndCloseLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        openAndCloseLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15).isActive = true
    }
    
    // MARK: - Public Methods
    
    func animateProgress(duration: Double, fromValue: Double) {
        // Reset progress to 0
        progressLayer.strokeEnd = 0.0
        
        // Create a new animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = 1.0
        animation.duration = TimeInterval(duration)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        // Update time label
        remainingTime = TimeInterval(duration)
        updateTimeLabel()
        
        // Add the animation to the layer
        progressLayer.add(animation, forKey: "progressAnimation")
        
        // Update time label every second
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            self.remainingTime -= 1
            self.updateTimeLabel()
            
            if self.remainingTime <= 0 {
                timer.invalidate()
                self.delegate?.didEndProgress()
            }
        }
    }
    
    private func updateTimeLabel() {
        let hours = Int(remainingTime) / 3600
        let minutes = (Int(remainingTime) % 3600) / 60
        let seconds = Int(remainingTime) % 60
        timeLabel.text = String(format: "-%02d:%02d:%02d", hours, minutes, seconds)
    }
}

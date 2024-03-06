//
//  SwiftUIView.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 21/02/24.
//

import UIKit
import AudioToolbox

final class TasbehViewController: UIViewController {

    var counter: Int = 0
    var bigTotal: Int = 0
    var is99Mode: Bool = false
    private var isCustomButtonImageChanged: Bool = false


    private let counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .appColor.countcolor
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bigTotalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var countButton: UIButton = {
        let button = makeButton(withImage: UIImage(named: "Counter"))
        button.addTarget(self, action: #selector(countButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var restartBarButton: UIBarButtonItem = {
        let restartButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.counterclockwise"),
            style: .plain,
            target: self,
            action: #selector(restartButtonTapped)
        )
        restartButton.tintColor = .black
        return restartButton
    }()
    private lazy var leftBarButton: UIBarButtonItem = {
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonTapped)
        )
        
        leftBarButton.tintColor = .black
        
        return leftBarButton
    }()

    private lazy var customBarButton: UIBarButtonItem = {
            let customButton = UIButton(type: .custom)
        customButton.setTitle("99", for: .normal)
        customButton.setTitleColor(.black, for: .normal)
        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            customButton.addTarget(self, action: #selector(customButtonTapped), for: .touchUpInside)
            let customBarButtonItem = UIBarButtonItem(customView: customButton)
            return customBarButtonItem
        }()

    private lazy var circleContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.addSublayer(circleShape)
        container.addSubview(counterLabel)
        counterLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        counterLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        return container
    }()

    private lazy var circleShape: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.appColor.countcolor.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = .round
        return shapeLayer
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.layoutMargins = .init(top: 50, left: 8, bottom: 50, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasbex"
        navigationController?.navigationBar.barTintColor = .appColor.restart
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItems = [restartBarButton, customBarButton]
        setupBackgroundImage()
        setUpelements()
        setupConstraints()
        updateLabels()
    }

    private func setUpelements() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(bigTotalLabel)
        stackView.addArrangedSubview(circleContainer)
        stackView.addArrangedSubview(countButton)
    }
    
    @objc private func restartButtonTapped() {
        counter = 0
        bigTotal = 0
        is99Mode = false
        updateLabels()

        UIView.animate(withDuration: 0.3, animations: {
            self.restartBarButton.customView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.restartBarButton.customView?.transform = .identity
            }
        }

        updateCircleShape()
        checkForVibration()
    }

    @objc private func customButtonTapped() {
           is99Mode.toggle()
           updateLabels()
           updateCircleShape()
        checkForVibration()
        
        if let customButton = customBarButton.customView as? UIButton {
            if isCustomButtonImageChanged {
                customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                customButton.setTitle("99", for: .normal)
            } else {
                customButton.setTitle("33", for: .normal)
            }
            isCustomButtonImageChanged.toggle()
        }
       }


    @objc private func countButtonTapped() {
        if is99Mode {
            if counter == 98 {
                bigTotal += 1
                counter = 0
            } else {
                counter += 1
            }
        } else {
            if counter == 32 {
                bigTotal += 1
                counter = 0
            } else {
                counter += 1
            }
        }

        updateLabels()
        updateCircleShape()
        checkForVibration()
    }
    
    @objc private func leftBarButtonTapped() {
        
        navigationController?.popViewController(animated: true)
    }
    
    private func checkForVibration() {
        if bigTotal > 0 {
        
            print("vibrated")
        }
    }


    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ramadanPicture")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }

    private func setupConstraints() {
  
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func updateLabels() {
        counterLabel.text = "\(counter)"
        bigTotalLabel.text = "Umumiy: \(bigTotal)"
    }

    private func makeButton(withImage image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.tintColor = .appColor.countcolor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func makeBackgroundImageView(named imageName: String) -> UIImageView {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    private func updateCircleShape() {
        let progress = CGFloat(counter) / 34.0

        // Update stroke end animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.1
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        circleShape.add(animation, forKey: "circleAnimation")

        // Update circle path
        let radius: CGFloat = 80
        let center = CGPoint(x: circleContainer.bounds.midX, y: circleContainer.bounds.midY)
        let startAngle: CGFloat = -.pi / 2
        var endAngle: CGFloat

        if is99Mode {
            endAngle = startAngle + 2 * .pi * (CGFloat(counter) / 100.0)
        } else {
            endAngle = startAngle + 2 * .pi * progress
        }

        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circleShape.path = path.cgPath
    }
}





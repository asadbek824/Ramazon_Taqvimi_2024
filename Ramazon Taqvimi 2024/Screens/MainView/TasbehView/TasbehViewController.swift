//
//  SwiftUIView.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 21/02/24.
//

import UIKit

class ViewController: UIViewController {
    var counter: Int = 0
    var bigTotal: Int = 0
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .appColor.countcolor
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bigTotalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)

        let counterImage = UIImage(named: "Counter")?.withRenderingMode(.alwaysOriginal)
        button.setImage(counterImage, for: .normal)
        button.tintColor = .appColor.countcolor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(countButtonTapped), for: .touchUpInside)
        
        return button
    }()

    
    let restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitle("Restart", for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setUpelements()
        setupConstraints()
        updateLabels()
    }
}

//MARK: setUpelements, setupBackgroundImage, setupConstraints
extension ViewController {
    // functions
    func setUpelements() {
        view.addSubview(countButton)
        view.addSubview(restartButton)
        view.addSubview(counterLabel)
        view.addSubview(bigTotalLabel)
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ramadanback")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            
            bigTotalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigTotalLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            
            countButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countButton.topAnchor.constraint(equalTo: bigTotalLabel.bottomAnchor, constant: 300),
            
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: bigTotalLabel.bottomAnchor, constant: 20),
        ])
    }
}

//MARK: Counter logic
extension ViewController {
    
    func updateLabels() {
        counterLabel.text = "\(counter)"
        bigTotalLabel.text = "Big Total: \(bigTotal)"
    }
    
    @objc func countButtonTapped() {
        counter += 1
        
        if counter == 34 {
            bigTotal += 1
            counter = 0
        }
        
        updateLabels()
    }
    
    @objc func restartButtonTapped() {
        counter = 0
        bigTotal = 0
        updateLabels()
    }
}

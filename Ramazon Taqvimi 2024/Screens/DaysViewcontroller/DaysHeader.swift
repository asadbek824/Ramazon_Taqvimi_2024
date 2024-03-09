//
//  File.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 23/02/24.
//

import UIKit

final class DaysTableHeaderView: UIView {

//MARK: Create Objects
    
    private let dayLabel: UILabel = makeLabel(withText: "Kun")
    private let dateLabel: UILabel = makeLabel(withText: "Sana")
    private let saharLabel: UILabel = makeLabel(withText: "Saharlik")
    private let iftarLabel: UILabel = makeLabel(withText: "Iftorlik")

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "header")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubviews(dayLabel, dateLabel, saharLabel, iftarLabel)

        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.widthAnchor.constraint(equalToConstant: 40),

            dateLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 10),
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 60),

            saharLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 89),
            saharLabel.widthAnchor.constraint(equalToConstant: 70),
            saharLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            iftarLabel.leadingAnchor.constraint(equalTo: saharLabel.trailingAnchor, constant: 16),
            iftarLabel.widthAnchor.constraint(equalToConstant: 60),
            iftarLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private static func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

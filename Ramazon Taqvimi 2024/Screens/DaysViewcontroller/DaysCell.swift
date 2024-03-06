
//
//  DaysCell.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 23/02/24.
//

import UIKit

final class DaysTableViewCell: UITableViewCell {
    
     let titleLabel = UILabel()
     let dateLabel = UILabel()
     let saharLabel = UILabel()
     let iftarLabel = UILabel()
     let haftaLabel = UILabel()
     let backgroundImage = UIImageView()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        iftarLabel.font = UIFont.boldSystemFont(ofSize: 18)
        saharLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.clipsToBounds = true
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = 15
        contentView.addSubview(blurEffectView)
        
        addSubview(backgroundImage)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(saharLabel)
        addSubview(iftarLabel)
        addSubview(haftaLabel)
       
 
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        saharLabel.translatesAutoresizingMaskIntoConstraints = false
        iftarLabel.translatesAutoresizingMaskIntoConstraints = false
        haftaLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 55),
            
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -12),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 120),
            
            haftaLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            haftaLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 13),
            haftaLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 120),
            
            saharLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 40),
            saharLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
            saharLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            iftarLabel.leadingAnchor.constraint(equalTo: saharLabel.trailingAnchor, constant: 5),
            iftarLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            iftarLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with indexPath: IndexPath, time: (String, String)) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        dateFormatter.locale = Locale(identifier: "uz_UZ")
        
        var components = DateComponents()
        components.year = 2024
        components.month = 3
        components.day = 11 // Start from March 11

        components.weekday = 2 // Monday
        let startDate = Calendar.current.date(from: components) ?? Date()
        
        let date = Calendar.current.date(
            byAdding: .day,
            value: indexPath.row,
            to: startDate
        ) ?? Date()
        
        dateLabel.text = dateFormatter.string(from: date)
        
        saharLabel.text = time.0
        iftarLabel.text = time.1
        
        let dayOfWeek = Calendar.current.component(.weekday, from: date)
        
        let dayNames = ["Yakshanba", "Dushanba", "Seshanba", "Chorshanba", "Payshanba", "Juma", "Shanba"]
        
        haftaLabel.text = dayNames[dayOfWeek - 1]
        titleLabel.text = "\(indexPath.row + 1)"
        backgroundColor = isToday(date) ? .systemBlue : .clear
   
        let rowsWithWhiteText = [5, 12, 19, 26]
        let shouldSetWhiteText = rowsWithWhiteText.contains(indexPath.row + 1)
        
        let textColor: UIColor = shouldSetWhiteText ? .white : .black
        
        titleLabel.textColor = textColor
        dateLabel.textColor = textColor
        saharLabel.textColor = textColor
        iftarLabel.textColor = textColor
        haftaLabel.textColor = textColor
    }

    private func isToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: date)
        return calendar.isDate(today, inSameDayAs: targetDate)
    }
}




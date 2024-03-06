//
//  File.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 16/02/24.
//

import UIKit
import AVFoundation

protocol DuaCellDelegate: AnyObject {
    func didTappedPlayButton(url: URL)
}

final class DuaCell: UITableViewCell, AVAudioPlayerDelegate {
    
    var index: Int = 0
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 15
        return blurEffectView
    }()
    
    //MARK: Objects
    private let arablabel: UILabel = makeLabel(fontSize: 20, color: .appColor.arablabel)
    private let openclose: UILabel = makeLabel(fontSize: 15, color: .black)
    private let uzlabel: UILabel = makeLabel(fontSize: 20, color: .black)
    private let manolabel: UILabel = makeLabel(fontSize: 14, color: .systemBrown)
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "stop_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: DuaCellDelegate?
    
    //MARK: Override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        setupCellViews()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: setupCellViews
    fileprivate func setupCellViews() {
        [blurEffectView, arablabel, uzlabel, manolabel, openclose, playButton].forEach {
            contentView.addSubview($0)
        }
        blurEffectView.clipsToBounds = true
    }
    
    func configureCell(index: Int, audioPlayer: AVAudioPlayer?) {
        self.index = index
        
        switch index {
        case 0:
            openclose.text = "Ro‘za tutish (saharlik, og‘iz yopish) duosi"
        case 1:
            arablabel.text = "نَوَيْتُ أَنْ أَصُومَ صَوْمَ شَهْرَ رَمَضَانَنَوَيْتُ أَنْ أَصُومَ صَوْمَ شَهْرَ رَمَضَانَ مِنَ الْفَجْرِ إِلَى الْمَغْرِبِ، خَالِصًا لِلهِ تَعَالَى أَللهُ أَكْبَرُ"
            uzlabel.text = "Navaytu an asuvma sovma shahri ramazona minal fajri ilal mag‘ribi, xolisan lillahi ta’aalaa Allohu akbar"
            manolabel.text = "Ma’nosi: Ramazon oyining ro‘zasini subhdan to kun botguncha tutmoqni niyat qildim. Xolis Alloh uchun Alloh buyukdir."
        case 2:
            openclose.text = "Iftorlik (og‘iz ochish) duosi"
        default:
            arablabel.text = "اَللَّهُمَّ لَكَ صُمْتُ وَ بِكَ آمَنْتُ وَ عَلَيْكَ تَوَكَّلْتُ وَ عَلَى رِزْقِكَ أَفْتَرْتُ، فَغْفِرْلِى مَا قَدَّمْتُ وَ مَا أَخَّرْتُ بِرَحْمَتِكَ يَا  الرَّاحِمِينَ أَرْحَمَ"
            uzlabel.text = "Allohumma laka sumtu va bika aamantu va a’layka tavakkaltu va a’laa rizqika aftartu, fag‘firliy ma qoddamtu va maa axxortu birohmatika yaa arhamar roohimiyn"
            manolabel.text = "Ma’nosi: Ey Alloh, ushbu Ro‘zamni Sen uchun tutdim va Senga iymon keltirdim va Senga tavakkal qildim va bergan rizqing bilan iftor qildim. Ey mehribonlarning eng mehriboni, mening avvalgi va keyingi gunohlarimni mag‘firat qilgil."
        }
    }
}

//MARK: setupConstraints'

extension DuaCell {
    fileprivate func setupConstraints() {
        [blurEffectView, arablabel, uzlabel, manolabel, openclose, playButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            openclose.centerYAnchor.constraint(equalTo: centerYAnchor),
            openclose.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            openclose.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -15),
            
            arablabel.topAnchor.constraint(equalTo: blurEffectView.topAnchor, constant: 20),
            arablabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            arablabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -15),
            
            uzlabel.topAnchor.constraint(equalTo: arablabel.bottomAnchor, constant: 10),
            uzlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            uzlabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -15),
            
            manolabel.topAnchor.constraint(equalTo: uzlabel.bottomAnchor, constant: 15),
            manolabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            manolabel.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor, constant: -15),
            
            playButton.topAnchor.constraint(equalTo: manolabel.bottomAnchor, constant: 15),
            playButton.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 20),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
}


//MARK: AudioPlay
extension DuaCell {
    @objc func playAudio(_ sender: UIButton) {
        let indexPath = IndexPath(row: index, section: 1)
        
        
        var audioFilename: String
        
        switch indexPath.row {
        case 1:
            audioFilename = "Ochish"
        case 3:
            audioFilename = "Yopish"
        default:
            return
        }
        
        guard let audioURL = Bundle.main.url(forResource: audioFilename, withExtension: "mp3") else {
            print("Audio file not found")
            return
        }
        let image = sender.imageView?.image == UIImage(named: "play_icon") ? UIImage(named: "stop_icon") : UIImage(named: "play_icon")
        playButton.setImage(image, for: .normal)
        delegate?.didTappedPlayButton(url: audioURL)
    }
}

private func makeLabel(fontSize: CGFloat, color: UIColor) -> UILabel {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: fontSize)
    label.textColor = color
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
}

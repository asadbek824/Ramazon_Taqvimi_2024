//
//  File.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 16/02/24.
//

import UIKit
import AVFoundation

class DuaCell: UITableViewCell {

    var audioPlayer: AVAudioPlayer?
    var audioURLs: [URL] = []
    var index: Int = 0
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0
        view.layer.shadowRadius = 5
        return view
    }()

    let arablabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()

    let openclose: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()

    let uzlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 5
        return label
    }()

    let manolabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .brown
        label.textAlignment = .left
        label.numberOfLines = 8
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play_icon"), for: .normal)
        button.addTarget(self, action: #selector(playAudio(_:)), for: .touchUpInside)
        return button
    }()
    
    let audioSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()

    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .appColor.primary
        setupCellViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupCellViews() {
        contentView.addSubview(cellView)
        cellView.addSubview(arablabel)
        cellView.addSubview(uzlabel)
        cellView.addSubview(manolabel)
        cellView.addSubview(openclose)
        cellView.addSubview(playButton)
        cellView.addSubview(audioSlider)
        
    }

    fileprivate func setupConstraints() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        arablabel.translatesAutoresizingMaskIntoConstraints = false
        uzlabel.translatesAutoresizingMaskIntoConstraints = false
        manolabel.translatesAutoresizingMaskIntoConstraints = false
        openclose.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        audioSlider.translatesAutoresizingMaskIntoConstraints = false
        

        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            openclose.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 11),
            openclose.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            openclose.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),

            arablabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            arablabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            arablabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),

            uzlabel.topAnchor.constraint(equalTo: arablabel.bottomAnchor, constant: 10),
            uzlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            uzlabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),

            manolabel.topAnchor.constraint(equalTo: uzlabel.bottomAnchor, constant: 15),
            manolabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            manolabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),
            
            playButton.topAnchor.constraint(equalTo: manolabel.bottomAnchor, constant: 15),
            playButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            playButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),

            audioSlider.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            audioSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            audioSlider.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -15),
        ])

        
        
    }

  
    @objc func playAudio(_ sender: UIButton) {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
            audioPlayer = nil
            playButton.setImage(UIImage(named: "play_icon"), for: .normal)
        } else {
            guard let audioURL = audioURLs.first else {
                if let audioURL = Bundle.main.url(forResource: "ramazan", withExtension: "m4a") {
                    audioURLs.append(audioURL)
                }
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                playButton.setImage(UIImage(named: "stop_icon"), for: .normal)
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }

    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        audioPlayer?.currentTime = TimeInterval(value) * (audioPlayer?.duration ?? 0)
    }

    func configureCell(index: Int) {
        self.index = index
        cellView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)

        switch index {
        case 0:
            openclose.text = "Ro‘za tutish (saharlik, og‘iz yopish) duosi"
        case 1:
            arablabel.text = "نَوَيْتُ أَنْ أَصُومَ صَوْمَ شَهْرَ رَمَضَانَ مِنَ الْفَجْرِ إِلَى الْمَغْرِبِ، خَالِصًا لِلهِ تَعَالَى أَللهُ أَكْبَرُ"
            uzlabel.text = "Navaytu an asuvma sovma shahri ramazona minal fajri ilal mag‘ribi, xolisan lillahi ta’aalaa Allohu akbar."
            manolabel.text = "Ma’nosi: Ramazon oyining ro‘zasini subhdan to kun botguncha tutmoqni niyat qildim. Xolis Alloh uchun Alloh buyukdir."
        case 2:
            openclose.text = "Iftorlik (og‘iz ochish) duosi"
        default:
            arablabel.text = "اَللَّهُمَّ لَكَ صُمْتُ وَ بِكَ آمَنْتُ وَ عَلَيْكَ تَوَكَّلْتُ وَ عَلَى رِزْقِكَ أَفْتَرْتُ، فَغْفِرْلِى مَا قَدَّمْتُ وَ مَا أَخَّرْتُ بِرَحْمَتِكَ يَا أَرْحَمَ الرَّاحِمِينَ"
            uzlabel.text = "Allohumma laka sumtu va bika aamantu va a’layka tavakkaltu va a’laa rizqika aftartu, fag‘firliy ma qoddamtu va maa axxortu birohmatika yaa arhamar roohimiyn."
            manolabel.text = "Ma’nosi: Ey Alloh, ushbu Ro‘zamni Sen uchun tutdim va Senga iymon keltirdim va Senga tavakkal qildim va bergan rizqing bilan iftor qildim. Ey mehribonlarning eng mehriboni, mening avvalgi va keyingi gunohlarimni mag‘firat qilgil."
        }
    }

}

import UIKit
import AVFoundation

extension DuaViewController {
    enum DuaType: String {
        case ochish
        case yopish
    }
}

final class DuaViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var duaType: DuaType = .ochish
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Duolar"
        view.backgroundColor = .clear
        setupTableView()
        setupBackgroundImage()
    }

    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DuaCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ramadanPicture")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
}

extension DuaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DuaCell else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.configureCell(index: indexPath.row, audioPlayer: audioPlayer)
        cell.playButton.isHidden = (indexPath.row == 0 || indexPath.row == 2)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return [70, 335, 70, 470][indexPath.row]
    }
}

extension DuaViewController: DuaCellDelegate, AVAudioPlayerDelegate {
    func didTappedPlayButton(url: URL) {
        
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
            return 
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
//            sender.setImage(UIImage(named: "stop_icon"), for: .normal)
        } catch let error {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

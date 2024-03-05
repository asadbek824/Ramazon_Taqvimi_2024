//
//  DuoViewController.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 22/02/24.
//

import UIKit

final class DuaViewController: UIViewController {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        view.backgroundColor = .clear
        title = "Duolar"
        setupTableView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    fileprivate func setupTableView() {
        
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        tableView.register(DuaCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)

        tableView.setConstraint(.left, from: view, 50)
        tableView.setConstraint(.right, from: view, 50)
        tableView.setConstraint(.bottom, from: view, 50)
        tableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 50
        ).isActive = true
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

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? DuaCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.configureCell(index: indexPath.row)

        switch indexPath.item {
        case 0:
            cell.playButton.isHidden = true
            cell.audioSlider.isHidden = true
        case 2:
            cell.playButton.isHidden = true
            cell.audioSlider.isHidden = true
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        } else if indexPath.row == 1 {
            return 340
        } else if indexPath.row == 2 {
            return 70
        } else {
            return 460
        }
    }
}

//
//  File.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 16/02/24.
//

import UIKit

class DuaViewController: UIViewController {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appColor.primary
        title = "Duolar"
        setupTableView()
        tableView.backgroundColor = .appColor.primary
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    fileprivate func setupTableView() {
        tableView.backgroundColor = .appColor.primary
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(DuaCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
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
        cell.configureCell(index: indexPath.row)
        
        switch indexPath.item {
        case 0: cell.playButton.isHidden = true
            cell.audioSlider.isHidden = true
        case 2: cell.playButton.isHidden = true
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
            return 350
        } else if indexPath.row == 2 {
            return 70
        } else {
            return 450
        }
    }
}

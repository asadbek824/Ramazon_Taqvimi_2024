//
//  30Days.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 23/02/24.
//

import UIKit

final class DaysViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Taqvim"
        setupBackgroundImage()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "ramadanPicture")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension DaysViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(
        in tableView: UITableView
    ) -> Int { 1 }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { 30 }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat { 70 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as! DaysTableViewCell
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        cell.isSelected = false
        cell.selectionStyle = .none
        cell.configure(with: indexPath, time: getTime(indexPath: indexPath))
        
        if indexPath.row == 4 {
            cell.backgroundImage.image = .madina
            
        } else if indexPath.row == 11 {
            cell.backgroundImage.image = .madina
        } else if indexPath.row == 18 {
            cell.backgroundImage.image = .madina
        } else if indexPath.row == 25 {
            cell.backgroundImage.image = .madina
        } else {
            cell.backgroundImage.image = nil
        }
        return cell
    }
    
    func getTime(indexPath: IndexPath) -> (String, String) {
        let userLocation = NamozVaqtlarManager.shared.getCoordinate()
        
        let prayerTimes = PrayerTime()
        let components = Calendar.current.dateComponents([.day, .month], from: Date())
        
        
        let day = indexPath.row + NamozVaqtlarManager.shared.startDate
        let mart = (components.month ?? 3)
        let month = mart
        
        
        let times = prayerTimes.main(
            coordinate: userLocation,
            month: month,
            day: day
        ).map { formatTime($0) }
        
        return (times[0], times[4])
    }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        
        return DaysTableHeaderView()
    }

    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat { 50.0 }
}

//
//  MainViewController.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 14/02/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - UIElements
    private let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


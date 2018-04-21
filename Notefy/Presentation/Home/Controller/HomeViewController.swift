//
//  HomeViewController.swift
//  Notefy
//
//  Created by Talip Göksu on 21.04.18.
//  Copyright © 2018 Iman Studios. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var navigationTitle = "Entries"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationTitle.localized()
        self.view.backgroundColor = .white
    }
}

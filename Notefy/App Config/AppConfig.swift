//
//  AppConfig.swift
//  Notefy
//
//  Created by Talip Göksu on 21.04.18.
//  Copyright © 2018 Iman Studios. All rights reserved.
//

import Foundation
import Swinject

struct AppConfig {
    let container: Container = {
        let container = Container()
        container.register(HomeViewController.self) { _ in
            HomeViewController()
        }
        container.register(RootNavigationController.self) { r in
            let controller = RootNavigationController()
            guard let homeVC = r.resolve(HomeViewController.self) else { return controller }
            controller.viewControllers = [homeVC]
            return controller
        }
        return container
    }()
}

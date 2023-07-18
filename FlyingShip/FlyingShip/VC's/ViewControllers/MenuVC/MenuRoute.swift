//
//  MenuRoute.swift
//  FlyingShip
//
//  Created by Nor1 on 12.07.2023.
//

import Foundation
import UIKit

protocol MenuRoute {
    func openMenu()
}

extension MenuRoute where Self: Router {
    func openMenu(transition: Transition) {
        let router = MainRouter(rootTransition: transition)
        let viewModel = MenuViewModel(router: router)
        let viewController = MenuVC(viewModel: viewModel)
        router.root = viewController
        route(to: viewController, as: transition)
        }
    func openMenu(){
        openMenu(transition: PushTransition())
    }
}

extension MainRouter: MenuRoute {}

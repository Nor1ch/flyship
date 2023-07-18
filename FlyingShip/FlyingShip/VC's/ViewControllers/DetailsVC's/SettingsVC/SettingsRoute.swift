//
//  SettingsRoute.swift
//  FlyingShip
//
//  Created by Nor1 on 14.07.2023.
//

import Foundation

protocol SettingsRoute {
    func openSettings(profile: Profile)
}

extension SettingsRoute where Self: Router {
    func openSettings(transition: Transition, profile: Profile) {
        let router = MainRouter(rootTransition: transition)
        let viewModel = SettingsViewModel(router: router)
        let viewController = SettingsVC(profile: profile, viewModel: viewModel)
        router.root = viewController
        route(to: viewController, as: transition)
        }
    func openSettings(profile: Profile){
        openSettings(transition: ModalTransition(), profile: profile)
    }
}

extension MainRouter: SettingsRoute {}

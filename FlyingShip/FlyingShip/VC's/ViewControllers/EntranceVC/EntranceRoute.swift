//
//  EntranceRoute.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//
import Foundation
import UIKit

protocol EntranceRoute {
    func makeEntrance() -> UIViewController
}

extension EntranceRoute where Self: Router {
    func makeEntrance() -> UIViewController {
        let router = MainRouter(rootTransition: EmptyTransition())
        let viewModel = EntranceViewModel(router: router)
        let viewController = EntranceVC(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: viewController)
        router.root = viewController
        navigation.isNavigationBarHidden = true
        return navigation
    }
}

extension MainRouter: EntranceRoute {}

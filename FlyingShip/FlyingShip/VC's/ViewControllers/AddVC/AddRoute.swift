//
//  AddRoute.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//
import Foundation
import UIKit

protocol AddRoute {
    func openAdd()
}

extension AddRoute where Self: Router {
    func openAdd(transition: Transition) {
        let router = MainRouter(rootTransition: EmptyTransition())
        let viewModel = AddVCViewModel(router: router)
        let viewController = AddVC(viewModel: viewModel)
        router.root = viewController
        route(to: viewController, as: transition)
        }
    func openAdd(){
        openAdd(transition: ModalTransition())
    }
}

extension MainRouter: AddRoute {}

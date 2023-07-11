//
//  AddVCViewModel.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation

final class AddVCViewModel {
    
    typealias Route = MainRouter
    private let router: Route
    
    let playerArray = [Constants.ImagesString.playerPlane_1,Constants.ImagesString.playerPlane_2,Constants.ImagesString.playerPlane_3,Constants.ImagesString.playerPlane_4,Constants.ImagesString.playerPlane_5]
    let backgroundArray = [Constants.ImagesString.background_1, Constants.ImagesString.background_2,Constants.ImagesString.background_3,]
    
    init(router: MainRouter){
        self.router = router
    }
}

//
//  SettingsViewModel.swift
//  FlyingShip
//
//  Created by Nor1 on 18.07.2023.
//

import Foundation

final class SettingsViewModel {
    
    typealias Route = MainRouter
    private let router: Route
    
    init(router: MainRouter){
        self.router = router
    }
    
    func closeSettings(){
        router.close()
    }
}

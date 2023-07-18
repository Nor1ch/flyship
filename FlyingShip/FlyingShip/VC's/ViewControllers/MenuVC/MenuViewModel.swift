//
//  MenuViewModel.swift
//  FlyingShip
//
//  Created by Nor1 on 12.07.2023.
//

import Foundation

final class MenuViewModel {
    typealias Route = MainRouter & SettingsRoute
    private let router: Route
    init(router: Route){
        self.router = router
    }
    
    func openSettings(profile: Profile){
        router.openSettings(profile: profile)
    }
    func closeMenu(){
        router.close()
    }
}

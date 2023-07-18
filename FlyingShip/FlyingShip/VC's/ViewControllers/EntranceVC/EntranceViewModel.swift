//
//  EntranceViewModel.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import Combine

final class EntranceViewModel {
    typealias Route = AddRoute & MenuRoute
    private let router: Route
    var profilesArray: [Profile] = []
    private var cancelable = Set<AnyCancellable>()
    
    init(router: Route){
        self.router = router
        ProfileManager.shared.$profiles
            .sink { array in
                self.profilesArray = array
            }
            .store(in: &cancelable)
    }
    
    
    func openAdd(){
        router.openAdd()
    }
    func openMenu(){
        router.openMenu()
    }
}

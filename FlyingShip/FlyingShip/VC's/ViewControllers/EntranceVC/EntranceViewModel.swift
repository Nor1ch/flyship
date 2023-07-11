//
//  EntranceViewModel.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation

final class EntranceViewModel {
    typealias Route = AddRoute
    private let router: Route
    init(router: Route){
        self.router = router
    }
    let testArray: [Profile] = [Profile(name: "Илья Черепанин", bestScroe: 300, image: nil, playerImage: "", backgroundImage: ""),Profile(name: "Ilia Cherepanin", bestScroe: 499, image: nil, playerImage: "", backgroundImage: ""),Profile(name: "ilia", bestScroe: 1500, image: nil, playerImage: "", backgroundImage: ""),Profile(name: "ilia", bestScroe: 10000, image: nil, playerImage: "", backgroundImage: ""),]
    func openAdd(){
        router.openAdd()
    }
}

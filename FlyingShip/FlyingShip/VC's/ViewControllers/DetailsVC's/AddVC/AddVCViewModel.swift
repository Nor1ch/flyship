//
//  AddVCViewModel.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation

final class AddViewModel {
    
    typealias Route = MainRouter
    private let router: Route
    
    init(router: MainRouter){
        self.router = router
    }
    
    func closeAdd(){
        router.close()
    }
}

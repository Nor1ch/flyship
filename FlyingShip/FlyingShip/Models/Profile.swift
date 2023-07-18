//
//  Profile.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation


struct Profile: Codable {
    let name: String
    var bestScore: Int
    let image: String?
    let playerImage: String
    let backgroundImage: String
}

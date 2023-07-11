//
//  Constants.swift
//  FlyingShip
//
//  Created by Nor1 on 29.06.2023.
//

import Foundation
import UIKit

enum Constants {
    enum ImagesString{
        static var background: String {
            "background"
        }
        static var playerPlane_1: String {
            "playerPlane_1"
        }
        static var enemyLarge: String {
            "largeEnemy"
        }
        static var enemyMedium: String {
            "mediumEnemy"
        }
        static var enemySmall: String {
            "smallEnemy"
        }
        static var playerRocket: String {
            "playerRocket"
        }
        static var gameOver: String {
            "gameOver"
        }
    }
    enum EmitterNames{
        static var explosion: String {
            "Explosion"
        }
    }
    enum Images {
        static var backgroundEntrance: UIImage? {
            UIImage(named: "backgroundEntrance")
        }
    }
    enum Fonts {
        static var logoLabel: UIFont? {
            UIFont(name: "papercut", size: 40)
        }
        static var profileName: UIFont? {
            UIFont(name: "pixelcyr_normal", size: 12)
        }
        static var profileScore: UIFont? {
            UIFont(name: "papercut", size: 22)
        }
    }
}

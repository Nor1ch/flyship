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
        static var background_1: String {
            "background_1"
        }
        static var background_2: String {
            "background_2"
        }
        static var background_3: String {
            "background_3"
        }
        static var playerPlane_1: String {
            "playerPlane_1"
        }
        static var playerPlane_2: String {
            "playerPlane_2"
        }
        static var playerPlane_3: String {
            "playerPlane_3"
        }
        static var playerPlane_4: String {
            "playerPlane_4"
        }
        static var playerPlane_5: String {
            "playerPlane_5"
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
        static var backgroundAdd: UIImage? {
            UIImage(named: "backgroundAdd")
        }
        static var defaultProfile: UIImage? {
            UIImage(named: "defaultProfile")
        }
        static var leftDoor: UIImage? {
            UIImage(named: "leftDoor")
        }
        static var rightDoor: UIImage? {
            UIImage(named: "rightDoor")
        }
    }
    enum Fonts {
        static var logoLabel: UIFont? {
            UIFont(name: "papercut", size: 55)
        }
        static var profileName: UIFont? {
            UIFont(name: "troika", size: 14)
        }
        static var profileScore: UIFont? {
            UIFont(name: "troika", size: 22)
        }
        static var changePhoto: UIFont? {
            UIFont(name: "troika", size: 15)
        }
        static var createButton: UIFont? {
            UIFont(name: "troika", size: 20)
        }
        static var textField: UIFont? {
            UIFont(name: "troika", size: 20)
        }
        static var header: UIFont? {
            UIFont(name: "troika", size: 25)
        }
    }
}
enum NameTypes {
    static let player = "player"
    static let background = "background"
    static let enemy = "enemy"
    static let font = "papercut"
    static let playerWeapon = "playerWeapon"
    
}

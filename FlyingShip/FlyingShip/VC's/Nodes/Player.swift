//
//  Player.swift
//  FlyingShip
//
//  Created by Nor1 on 08.07.2023.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    let playerSize: CGSize
    init(image: String, size: CGSize, position: CGFloat){
        self.playerSize = size
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: .white, size: playerSize)
        
        self.size = playerSize
        self.name = "player"
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.zPosition = 1
        self.position = CGPoint(x: 0, y: position - self.size.width*5)
//        physicsBody = SKPhysicsBody(texture: texture, size: self.size)
        physicsBody = SKPhysicsBody(circleOfRadius: self.frame.width/2)
        physicsBody?.categoryBitMask = Collision.player.rawValue
        physicsBody?.collisionBitMask = Collision.enemy.rawValue | Collision.enemyWeapon.rawValue
        physicsBody?.contactTestBitMask = Collision.enemy.rawValue | Collision.enemyWeapon.rawValue
        physicsBody?.isDynamic = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

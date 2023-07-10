//
//  Enemy.swift
//  FlyingShip
//
//  Created by Nor1 on 08.07.2023.
//

import Foundation
import SpriteKit


class Enemy: SKSpriteNode {
    let type: EnemyType
    var lastFire: Double = 0
    var shields: Int
    var enemySize: CGFloat
    
    init(type: EnemyType, startPositionY: CGFloat ,minX: CGFloat, maxX: CGFloat){
        self.type = type
        shields = type.shields
        enemySize = type.enemySize
        let texture = SKTexture(imageNamed: type.name)
        
        super.init(texture: texture, color: .white, size: CGSize(width: enemySize, height: enemySize))
        
        physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: enemySize, height: enemySize))
        physicsBody?.categoryBitMask = Collision.enemy.rawValue
        physicsBody?.collisionBitMask = Collision.player.rawValue | Collision.playerWeapon.rawValue
        physicsBody?.contactTestBitMask = Collision.player.rawValue | Collision.playerWeapon.rawValue
        name = "enemy"
        let positionOffsetX = Int.random(in: Int((minX + enemySize))...Int((maxX - enemySize)))
        position = CGPoint(x: CGFloat(positionOffsetX), y: startPositionY + enemySize/2)
        makePath()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makePath(){
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: -self.frame.maxY*2 + self.enemySize))
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: false, speed: type.speed)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        run(sequence)
    }
    private func doRocket(){
    }
}

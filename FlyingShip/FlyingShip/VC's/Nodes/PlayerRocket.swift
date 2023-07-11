//
//  playerRocket.swift
//  FlyingShip
//
//  Created by Nor1 on 10.07.2023.
//

import SpriteKit

private extension CGFloat {
    static let rocketWidth = 10.0
    static let rocketHeight = 20.0
}
class PlayerRocket: SKSpriteNode {
    private var maxY: CGFloat
    
    init(position: CGPoint, maxY: CGFloat){
 
        let texture = SKTexture(imageNamed: Constants.ImagesString.playerRocket)
        self.maxY = maxY
        
        super.init(texture: texture, color: .white, size: CGSize(width: CGFloat.rocketWidth, height: CGFloat.rocketHeight))
        
        self.position = position
//        physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: CGFloat.rocketWidth, height: CGFloat.rocketHeight))
        physicsBody = SKPhysicsBody(circleOfRadius: 15)
        physicsBody?.categoryBitMask = Collision.playerWeapon.rawValue
        physicsBody?.collisionBitMask = Collision.enemy.rawValue | Collision.enemyWeapon.rawValue
        physicsBody?.contactTestBitMask = Collision.enemy.rawValue | Collision.enemyWeapon.rawValue
        name = "playerWeapon"
        makePath()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func makePath(){
        let movement = SKAction.move(to: CGPoint(x: self.position.x, y: self.maxY*2), duration: 5)
        let sequence = SKAction.sequence([movement, .removeFromParent()])
        self.run(sequence)
    }
}

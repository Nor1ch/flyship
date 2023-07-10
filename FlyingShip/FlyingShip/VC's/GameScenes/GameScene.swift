//
//  GameScene.swift
//  FlyingShip
//
//  Created by Nor1 on 29.06.2023.
//

import SpriteKit
import GameplayKit

private extension CGFloat {
    static let playerSize = 60.0
    static let smallEnemySize = 50.0
    static let mediunEnemySize = 70.0
    static let largeEnemySize = 90.0
    static let smallEnemyShield = 1
    static let mediumEnemyShield = 2
    static let largeEnemyShield = 3
    static let smallEnemySpeed = 200.0
    static let mediumEnemySpeed = 150.0
    static let largeEnemySpeed = 100.0
}
protocol setupGameSceneDelegate: AnyObject {
    
}

enum Collision: UInt32 {
    case player = 1
    case playerWeapon = 2
    case enemy = 4
    case enemyWeapon = 8
}

class GameScene: SKScene {
    private var background: String
    private var player: SKSpriteNode
    private var gameTimer: Timer?
    private var isPlayerAlive = true
    private var playerLives = 10
    private let enemiesType: [EnemyType] = [EnemyType(name: Constants.ImagesString.enemySmall, shields: CGFloat.smallEnemyShield, speed: CGFloat.smallEnemySpeed, enemySize: CGFloat.smallEnemySize), EnemyType(name: Constants.ImagesString.enemyMedium, shields: CGFloat.mediumEnemyShield, speed: CGFloat.mediumEnemySpeed, enemySize: CGFloat.mediunEnemySize), EnemyType(name: Constants.ImagesString.enemyLarge, shields: CGFloat.largeEnemyShield, speed: CGFloat.largeEnemySpeed, enemySize: CGFloat.largeEnemySize)]
    
    weak var setupDelegate: setupGameSceneDelegate?
    
    init(size: CGSize, player: String, background: String){
        self.player = Player(image: player, size: CGSize(width: CGFloat.playerSize, height: CGFloat.playerSize), position: UIScreen.main.bounds.minY)
        self.background = background
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        createBackground()
        addEnemy()
        gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        addChild(player)
    }
    override func update(_ currentTime: TimeInterval) {
        animateBackground()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isPlayerAlive else { return }
        guard let touch = touches.first else { return }
        let nodes = nodes(at: touch.location(in: self))
        if nodes.contains(player) {
            let shot = PlayerRocket(position: player.position, maxY: self.frame.maxY)
            addChild(shot)
        } else {
            let position = touch.location(in: self).x
            if position + player.size.width > frame.maxX {
                player.run(SKAction.move(to: CGPoint(x: frame.maxX - player.size.width, y: player.position.y), duration: 0.3))
            } else if position + (-player.size.width) < frame.minX {
                player.run(SKAction.move(to: CGPoint(x: frame.minX + player.size.width, y: player.position.y), duration: 0.3))
            } else {
                player.run(SKAction.move(to: CGPoint(x: touch.location(in: self).x, y: player.position.y), duration: 0.3))
            }
        }
    }
    
    private func createBackground(){
        for i in 0...1 {
            let background = SKSpriteNode(imageNamed: background)
            if let scene = self.scene {
                background.name = "Background"
                background.size = CGSize(width: scene.size.width, height: scene.size.height)
                background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                background.position = CGPoint(x: 0, y: CGFloat(i) * background.size.height)
                background.zPosition = -1
                scene.addChild(background)
            }
        }
    }
    private func animateBackground(){
        self.enumerateChildNodes(withName: "Background", using: {
            (node, error) in
            node.position.y -= 2
                if node.position.y < -node.frame.size.height {
                    node.position.y += (node.frame.size.height) * 2
            }
        })
    }
    private func makeExplosion(position: CGPoint){
        if let explosion = SKEmitterNode(fileNamed: Constants.EmitterNames.explosion) {
            explosion.position = position
            addChild(explosion)
            explosion.run(SKAction.wait(forDuration: 2), completion: { explosion.removeFromParent()})
        }
    }
    @objc private func addEnemy(){
            let enemyType = Int.random(in: 0...self.enemiesType.count-1)
            let enemy = Enemy(type: self.enemiesType[enemyType], startPositionY: self.frame.maxY, minX: self.frame.minX, maxX: self.frame.maxX)
            self.addChild(enemy)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        let sortedNodes = [nodeA,nodeB].sorted { $0.name ?? "" < $1.name ?? "" }
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if secondNode.name == "player" {
            guard isPlayerAlive else { return }
            makeExplosion(position: firstNode.position)
            playerLives -= 1
            if playerLives == 0 {
                print("gameover")
                secondNode.removeFromParent()
            }
            firstNode.removeFromParent()
        } else if let enemy = firstNode as? Enemy {
            enemy.shields -= 1
            
            if enemy.shields == 0 {
                makeExplosion(position: enemy.position)
                enemy.removeFromParent()
            }
            makeExplosion(position: enemy.position)
            secondNode.removeFromParent()
        } else {
            makeExplosion(position: secondNode.position)
            firstNode.removeFromParent()
            secondNode.removeFromParent()
        }
    }
}

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
    static let smallEnemySpeed = 150.0
    static let mediumEnemySpeed = 125.0
    static let largeEnemySpeed = 100.0
    static let anchorOffset = 0.5
    static let offSetLeft = 100.0
    static let fontSize = 36.0
    static let levelFontSize = 56.0
}
protocol GameSceneDelegate: AnyObject {
    func gameOver(score: Int)
}

//MARK: - collision enum

enum Collision: UInt32 {
    case player = 1
    case playerWeapon = 2
    case enemy = 4
    case enemyWeapon = 8
}

final class GameScene: SKScene {
   
//MARK: - var/let
    
    private var background: String
    private var player: SKSpriteNode
    private var scoreLabel: SKLabelNode?
    private var liveLabel: SKLabelNode?
    private var levelLabel: SKLabelNode?
    private var gameOverLabel: SKSpriteNode?
    private var gameTimer: Timer?
    
    private var level: Int = 1 {
        didSet {
            gameLevel()
        }
    }
    private var score: Int = 0 {
        didSet {
            scoreLabel?.text = "Score: " + "\(score)"
            if score == 50 {
                level = 2
            } else if score == 150 {
                level = 3
            } else if score == 300 {
                level = 4
            }
        }
    }
    private var playerLives = 3 {
        didSet {
            liveLabel?.text = "Live: " + "\(playerLives)"
        }
    }
    private var isPlayerAlive = true
    private let enemiesType: [EnemyType] = [EnemyType(name: Constants.ImagesString.enemySmall, shields: CGFloat.smallEnemyShield, speed: CGFloat.smallEnemySpeed, enemySize: CGFloat.smallEnemySize), EnemyType(name: Constants.ImagesString.enemyMedium, shields: CGFloat.mediumEnemyShield, speed: CGFloat.mediumEnemySpeed, enemySize: CGFloat.mediunEnemySize), EnemyType(name: Constants.ImagesString.enemyLarge, shields: CGFloat.largeEnemyShield, speed: CGFloat.largeEnemySpeed, enemySize: CGFloat.largeEnemySize)]
    
    weak var gameSceneDelegate: GameSceneDelegate?

//MARK: - init
    
    init(size: CGSize, playerTexture: String, backgroundTexture: String){
        self.player = Player(image: playerTexture, size: CGSize(width: CGFloat.playerSize, height: CGFloat.playerSize), position: UIScreen.main.bounds.minY)
        self.background = backgroundTexture
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - lifecycle
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: CGFloat.anchorOffset, y: CGFloat.anchorOffset)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        setupLabels()
        createBackground()
        createEnemies()
        addChild(player)
    }
    override func update(_ currentTime: TimeInterval) {
        animateBackground()
    }
    
//MARK: - animate player movement
    
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
    
//MARK: - private funcs setupView
    
    private func createBackground(){
        for i in 0...1 {
            let background = SKSpriteNode(imageNamed: background)
            if let scene = self.scene {
                background.name = NameTypes.background
                background.size = CGSize(width: scene.size.width, height: scene.size.height)
                background.anchorPoint = CGPoint(x: CGFloat.anchorOffset, y: CGFloat.anchorOffset)
                background.position = CGPoint(x: 0, y: CGFloat(i) * background.size.height)
                background.zPosition = -1
                scene.addChild(background)
            }
        }
    }
    private func setupLabels(){
        scoreLabel = SKLabelNode(text: "Score: 0")
        liveLabel = SKLabelNode (text: "Live: " + "\(playerLives)")
        guard let scoreLabel = scoreLabel, let liveLabel = liveLabel else { return }
        scoreLabel.position = CGPoint(x: frame.minX + CGFloat.offSetLeft, y: frame.maxY - scoreLabel.frame.size.width/2)
        scoreLabel.fontSize = CGFloat.fontSize
        scoreLabel.fontColor = .white
        scoreLabel.fontName = NameTypes.font
        scoreLabel.zPosition = 0
        
        liveLabel.position = CGPoint(x: frame.minX + CGFloat.offSetLeft, y: scoreLabel.position.y - liveLabel.frame.size.height)
        liveLabel.fontSize = CGFloat.fontSize
        liveLabel.fontColor = .white
        liveLabel.fontName = NameTypes.font
        liveLabel.zPosition = 0
        addChild(scoreLabel)
        addChild(liveLabel)
    }
    private func gameLevel(){
        levelLabel = SKLabelNode(text: "Level: " + "\(level)")
        if let levelLabel = levelLabel {
            levelLabel.fontSize = CGFloat.levelFontSize
            levelLabel.fontColor = .white
            levelLabel.fontName = NameTypes.font
            levelLabel.position = CGPoint(x: 0, y: 0)
            addChild(levelLabel)
            levelLabel.run(SKAction.wait(forDuration: 2), completion: { levelLabel.removeFromParent()})
        }
    }

//MARK: - animations
    private func makeExplosion(position: CGPoint){
        if let explosion = SKEmitterNode(fileNamed: Constants.EmitterNames.explosion) {
            explosion.position = position
            addChild(explosion)
            explosion.run(SKAction.wait(forDuration: 2), completion: { explosion.removeFromParent()})
        }
    }
    private func animateBackground(){
        self.enumerateChildNodes(withName: NameTypes.background, using: {
            (node, error) in
            node.position.y -= 2
                if node.position.y < -node.frame.size.height {
                    node.position.y += (node.frame.size.height) * 2
            }
        })
    }
    
//MARK: - gameOver func
    
    private func gameOver(){
        isPlayerAlive = false
        self.enumerateChildNodes(withName: NameTypes.enemy) { node, error in
            node.removeFromParent()
        }
        gameOverLabel = SKSpriteNode(imageNamed: Constants.ImagesString.gameOver)
        if let gameOverLabel = gameOverLabel {
            addChild(gameOverLabel)
        }
        gameSceneDelegate?.gameOver(score: self.score)
    }
    
//MARK: - setup Enemies
    
    private func createEnemies(){
        let pauser = SKAction.wait(forDuration: 2.0)
        let trigger = SKAction.perform(#selector(addEnemy), onTarget: self)
        let pauseThenTrigger = SKAction.sequence([ pauser, trigger ])
        let repeatForever = SKAction.repeatForever(pauseThenTrigger)
        self.run( repeatForever )
    }
    @objc private func addEnemy(){
        guard isPlayerAlive else { return }
        let enemyType = Int.random(in: 0...self.enemiesType.count-1)
        let enemy = Enemy(type: self.enemiesType[enemyType], startPositionY: self.frame.maxY, minX: self.frame.minX, maxX: self.frame.maxX)
        let speed = enemy.speed
        enemy.speed = speed * CGFloat(level)
        addChild(enemy)
    }
}

//MARK: - extension physicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        let sortedNodes = [nodeA,nodeB].sorted { $0.name ?? "" < $1.name ?? "" }
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if secondNode.name == NameTypes.player {
            guard isPlayerAlive else { return }
            makeExplosion(position: firstNode.position)
            playerLives -= 1
            if playerLives == 0 {
                gameOver()
                secondNode.removeFromParent()
            }
            firstNode.removeFromParent()
        } else if let enemy = firstNode as? Enemy {
            enemy.shields -= 1
            
            if enemy.shields == 0 {
                makeExplosion(position: enemy.position)
                score += 5
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

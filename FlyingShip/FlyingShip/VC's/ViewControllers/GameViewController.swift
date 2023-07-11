//
//  GameViewController.swift
//  FlyingShip
//
//  Created by Nor1 on 29.06.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        showGame()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func showGame(){
        if let view = self.view as! SKView? {
            let scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), player: Constants.ImagesString.playerPlane_1, background: Constants.ImagesString.background)
            scene.scaleMode = .aspectFill
            scene.setupDelegate = self
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

extension GameViewController: setupGameSceneDelegate {
    
}

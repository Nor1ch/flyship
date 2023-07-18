//
//  MenuVC.swift
//  FlyingShip
//
//  Created by Nor1 on 12.07.2023.
//

import Foundation
import SnapKit
import SpriteKit
import GameplayKit
import UIKit

final class MenuVC: UIViewController {
    
//MARK: - let/var
    
    private let viewModel: MenuViewModel
    private var restartFlag: Bool = false
    private var profile: Profile?
    private lazy var menuView: MenuView = MenuView()
    private lazy var skView = SKView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
//MARK: - init
    init(viewModel: MenuViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        profile = ProfileManager.shared.currentProfile
    }
    
//MARK: - private funcs
    
    private func setupViews(){
        view.addSubview(skView)
        skView.isPaused = true
        view.addSubview(menuView)
        menuView.delegate = self
    }
    private func makeConstraints(){
        menuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//MARK: - orientation and statusBar
    
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
    
//MARK: - create gameScene
    
    private func showGame(){
        if let profile = profile {
            let scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), playerTexture: profile.playerImage, backgroundTexture: profile.backgroundImage)
            scene.scaleMode = .aspectFill
            scene.gameSceneDelegate = self
            skView.presentScene(scene)
            skView.ignoresSiblingOrder = true
            skView.isPaused = false
        }
    }
}

//MARK: - extension menuView delegate

extension MenuVC: MenuViewDelegate {
    func startGame() {
        showGame()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.view.bringSubviewToFront(self.skView)
            }
    }
    func setupPlayer() {
        if let profile = profile {
        viewModel.openSettings(profile: profile)
        }
    }
    func backToPlayers() {
        if let profile = profile {
            ProfileManager.shared.updateProfile(profile: profile)
            ProfileManager.shared.currentProfile = profile
        }
        viewModel.closeMenu()
    }
}

//MARK: - extension gameScene delegate

extension MenuVC: GameSceneDelegate {

    func gameOver(score: Int) {
        if profile?.bestScore ?? 0 < score {
            profile?.bestScore = score
            if let profile = profile {
                ProfileManager.shared.updateProfile(profile: profile)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.view.bringSubviewToFront(self.menuView)
            self.menuView.returnMenuView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.skView.isPaused = true
            }
        }
    }
}

//MARK: - extension detailsVC delegate

extension MenuVC: DetailsVCDelegate {
    func returnProfile(profile: Profile) {
        if self.profile != nil {
            self.profile = profile
            ProfileManager.shared.updateProfile(profile: profile)
        }
    }
}

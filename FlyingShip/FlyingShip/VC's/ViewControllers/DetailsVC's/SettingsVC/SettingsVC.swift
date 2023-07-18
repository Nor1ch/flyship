//
//  SettingsVC.swift
//  FlyingShip
//
//  Created by Nor1 on 14.07.2023.
//

import Foundation
import UIKit

final class SettingsVC: DetailsVC {

    private var profile: Profile
    private let viewModel: SettingsViewModel
    
    init(profile: Profile, viewModel: SettingsViewModel){
        self.profile = profile
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    private func setupViews(){
        setupCreateButton(title: "Let's continue", selector: #selector(buttonTapped), isEnabled: true)
        setupIndexes(profile: profile)
        setupTextField(name: profile.name)
        setupImage(image: profile.image)
    }
    @objc private func buttonTapped(){
        let images = takeCurrentProfileImages()
        let currentProfile = Profile(name: profile.name, bestScore: profile.bestScore, image: images.image, playerImage: images.player, backgroundImage: images.background)
        delegate?.returnProfile(profile: currentProfile)
        viewModel.closeSettings()
    }
}

//
//  AddVC.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import SnapKit
import UIKit

final class AddVC: DetailsVC {
    
    private let viewModel: AddViewModel

    init(viewModel: AddViewModel){
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
        setupCreateButton(title: "Well done, buddy", selector: #selector(buttonTapped), isEnabled: false)
    }
    @objc private func buttonTapped(){
        let profile = takeCurrentProfile()
        delegate?.returnProfile(profile: profile)
        viewModel.closeAdd()
    }
}

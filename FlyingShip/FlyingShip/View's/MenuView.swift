//
//  MenuView.swift
//  FlyingShip
//
//  Created by Nor1 on 12.07.2023.
//

import Foundation
import SnapKit
import UIKit

private extension CGFloat {
    static let cornerRadius = 15.0
    static let buttonHeight = 60.0
    static let offset = 60.0
    static let offsetBetween = 20.0
    static let multipliedBy05 = 0.5
    static let multipliedBy08 = 0.8
}

protocol MenuViewDelegate: AnyObject {
    func startGame()
    func setupPlayer()
    func backToPlayers()
}

final class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    
//MARK: - child views
    
    private lazy var leftDoorImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.leftDoor
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        return view
    }()
    private lazy var rightDoorImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.rightDoor
        view.backgroundColor = .green
        view.contentMode = .scaleToFill
        return view
    }()
    private lazy var containerButtons: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var startButton: UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.filled()
        let attr : [NSAttributedString.Key: Any] = [
            .font : Constants.Fonts.createButton as Any,
            .foregroundColor : UIColor.black as Any
        ]
        let title = "Start"
        config.titleAlignment = .center
        config.baseBackgroundColor = .white
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attr))
        config.background.cornerRadius = CGFloat.cornerRadius
        config.cornerStyle = .fixed
        view.configuration = config
        view.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return view
    }()
    private lazy var settingsButton : UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.filled()
        let attr : [NSAttributedString.Key: Any] = [
            .font : Constants.Fonts.createButton as Any,
            .foregroundColor : UIColor.black as Any
        ]
        let title = "Settings"
        config.titleAlignment = .center
        config.baseBackgroundColor = .white
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attr))
        config.background.cornerRadius = CGFloat.cornerRadius
        config.cornerStyle = .fixed
        view.configuration = config
        view.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return view
    }()
    private lazy var exitButton : UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.filled()
        let attr : [NSAttributedString.Key: Any] = [
            .font : Constants.Fonts.createButton as Any,
            .foregroundColor : UIColor.black as Any
        ]
        let title = "Exit"
        config.titleAlignment = .center
        config.baseBackgroundColor = .white
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attr))
        config.background.cornerRadius = CGFloat.cornerRadius
        config.cornerStyle = .fixed
        view.configuration = config
        view.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        return view
    }()

//MARK: - init
        
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupViews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - private funcs
        
    private func setupViews(){
        addSubview(leftDoorImage)
        addSubview(rightDoorImage)
        addSubview(containerButtons)
        containerButtons.addSubview(startButton)
        containerButtons.addSubview(settingsButton)
        containerButtons.addSubview(exitButton)
    }
    private func makeConstraints(){
        leftDoorImage.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy05)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        rightDoorImage.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy05)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        containerButtons.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.offset)
            make.right.equalToSuperview().inset(CGFloat.offset)
            make.height.equalTo(CGFloat.buttonHeight)
            make.centerY.equalToSuperview().multipliedBy(CGFloat.multipliedBy08)
        }
        settingsButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.offset)
            make.right.equalToSuperview().inset(CGFloat.offset)
            make.height.equalTo(CGFloat.buttonHeight)
            make.top.equalTo(startButton.snp.bottom).offset(CGFloat.offsetBetween)
        }
        exitButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.offset)
            make.right.equalToSuperview().inset(CGFloat.offset)
            make.height.equalTo(CGFloat.buttonHeight)
            make.top.equalTo(settingsButton.snp.bottom).offset(CGFloat.offset)
        }
    }
    private func animateStartGame(){
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseInOut) {
            self.leftDoorImage.snp.remakeConstraints { make in
                make.left.equalToSuperview().inset(-self.leftDoorImage.bounds.width)
                make.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy05)
                make.centerY.equalToSuperview()
            }
            self.rightDoorImage.snp.remakeConstraints { make in
                make.right.equalToSuperview().offset(self.rightDoorImage.bounds.width)
                make.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy05)
                make.centerY.equalToSuperview()
            }
            self.containerButtons.snp.remakeConstraints { make in
                make.height.width.equalToSuperview()
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview().multipliedBy(-1)
            }
            self.layoutIfNeeded()
        }
    }
 
//MARK: - actions
    
    @objc private func startTapped(){
        animateStartGame()
        delegate?.startGame()
    }
    @objc private func settingsTapped(){
        delegate?.setupPlayer()
    }
    @objc private func exitTapped(){
        delegate?.backToPlayers()
    }
    
//MARK: - animation return
    
    func returnMenuView(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut){
            self.leftDoorImage.snp.remakeConstraints { make in
                make.left.equalToSuperview()
                make.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy05)
                make.centerY.equalToSuperview()
            }
            self.rightDoorImage.snp.remakeConstraints { make in
                make.right.equalToSuperview()
                make.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy05)
                make.centerY.equalToSuperview()
            }
            self.containerButtons.snp.remakeConstraints { make in
                make.height.width.equalToSuperview()
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }
}

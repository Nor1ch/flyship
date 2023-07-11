//
//  EntranceTableViewCell.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import UIKit

private extension CGFloat {
    static let offsetParent = 5.0
    static let containerCornerRadius = 20.0
    static let offset10 = 10.0
}

final class EntranceTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat.containerCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var profileName: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.profileName
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    private lazy var profileScore: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.profileScore
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
        layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.frame.size.width
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews(){
        addSubview(containerView)
        containerView.addSubview(profileImage)
        containerView.addSubview(profileScore)
        containerView.addSubview(profileName)
        backgroundColor = .clear
        
    }
    private func makeConstraints(){
        containerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(CGFloat.offsetParent)
            make.right.bottom.equalToSuperview().inset(CGFloat.offsetParent)
        }
        profileImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.offset10)
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.bottom.equalToSuperview().inset(CGFloat.offset10)
            make.width.equalTo(profileName.snp.height)
        }
        profileScore.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.right.bottom.equalToSuperview().inset(CGFloat.offset10)
            make.width.equalTo(profileScore.snp.height)
        }
        profileName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.offset10)
            make.bottom.equalToSuperview().inset(CGFloat.offset10)
            make.left.equalTo(profileImage.snp.right).offset(CGFloat.offsetParent)
            make.right.equalTo(profileScore.snp.left)
        }
    }
    func setupCell(model: Profile){
        profileName.text = model.name
        profileScore.text = "Score: " + "\(model.bestScroe)"
        if model.image == nil {
            profileImage.image = UIImage(named: Constants.ImagesString.playerPlane_1)
        }
    }
}

//
//  EntranceTableViewCellADD.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import SnapKit
import UIKit

private extension CGFloat {
    static let size = 50.0
    static let containerCornerRadius = 20.0
    static let offsetParent = 5.0
}
final class EntranceTableViewCellADD: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = CGFloat.containerCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var plusImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "plus")
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
        backgroundColor = .clear
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(containerView)
        containerView.addSubview(plusImage)
    }
    private func makeConstraints(){
        containerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(CGFloat.offsetParent)
            make.right.bottom.equalToSuperview().inset(CGFloat.offsetParent)
        }
        plusImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(CGFloat.size)
        }
    }
}

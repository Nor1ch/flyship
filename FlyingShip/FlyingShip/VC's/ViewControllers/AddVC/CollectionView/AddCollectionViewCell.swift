//
//  AddCollectionViewCell.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//
import Foundation
import UIKit

private extension CGFloat {
    static let offset = 5.0
    static let cornerRadius = 15.0
}

final class AddCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = CGFloat.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(imageView)
        layer.cornerRadius = CGFloat.cornerRadius
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0
        clipsToBounds = true
    }
    private func makeConstraints(){
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    func setupCell(imageString: String){
        imageView.image = UIImage(named: imageString)
    }
}

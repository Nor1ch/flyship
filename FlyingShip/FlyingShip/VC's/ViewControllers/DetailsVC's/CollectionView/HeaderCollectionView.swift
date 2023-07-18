//
//  HeaderCollectionView.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import SnapKit
import UIKit

final class HeaderCollectionView: UICollectionReusableView {
    private lazy var headeTitle: UILabel = {
        let view = UILabel()
        view.font = Constants.Fonts.header
        view.textColor = .black
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
        
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    private func setupViews(){
        addSubview(headeTitle)
    }
    private func makeConstraints(){
        headeTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.top.equalToSuperview()
        }
    }
    func setupHeader(title: String){
        headeTitle.text = title
    }
}

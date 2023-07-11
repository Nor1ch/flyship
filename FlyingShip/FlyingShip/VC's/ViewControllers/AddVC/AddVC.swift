//
//  AddVC.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import SnapKit
import UIKit

private extension CGFloat {
    static let multipliedBy03 = 0.3
    static let cornerRadius = 15.0
    static let buttonHeight = 50.0
    static let buttonWidth = 150.0
    static let imageOffset = 20.0
    static let textFieldOffset = 20.0
    static let buttonOffset = 40.0
    static let multipliedBy04 = 0.4
    static let collectionViewOffset = 10.0
}

protocol AddVCDelegate: AnyObject {
    
}

final class AddVC: UIViewController {
    
    private let viewModel: AddVCViewModel
    private var indexPlayer: IndexPath = IndexPath(row: 0, section: 0)
    private var indexBackground: IndexPath = IndexPath(row: 0, section: 1)
    
    private lazy var backgorundImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.backgroundAdd
        view.layer.cornerRadius = CGFloat.cornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.defaultProfile
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = CGFloat.cornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var changeButton : UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.plain()
        let attr : [NSAttributedString.Key: Any] = [
            .font : Constants.Fonts.changePhoto as Any,
            .foregroundColor : UIColor.black as Any
        ]
        let title = "Change photo"
        config.titleAlignment = .center
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attr))
        view.configuration = config
        view.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        return view
    }()
    private lazy var createButton : UIButton = {
        let view = UIButton()
        var config = UIButton.Configuration.filled()
        let attr : [NSAttributedString.Key: Any] = [
            .font : Constants.Fonts.createButton as Any,
            .foregroundColor : UIColor.orange as Any
        ]
        let title = "Well done, buddy"
        config.titleAlignment = .center
        config.baseBackgroundColor = .cyan
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attr))
        config.background.cornerRadius = CGFloat.cornerRadius
        config.cornerStyle = .fixed
        view.configuration = config
        view.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout.playerAndBackgroundFlow())
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()
    private lazy var textField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .lightGray
        view.font = Constants.Fonts.textField
        view.placeholder = "What is your name?"
        view.textAlignment = .center
        view.layer.cornerRadius = CGFloat.cornerRadius
        return view
    }()
    
    init(viewModel: AddVCViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        setupCollectionView()
    }
    
    private func setupViews(){
        view.addSubview(backgorundImage)
        view.addSubview(profileImage)
        view.addSubview(changeButton)
        view.addSubview(textField)
        view.addSubview(createButton)
        view.addSubview(collectionView)
    }
    private func makeConstraints(){
        backgorundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat.imageOffset)
            make.width.equalToSuperview().multipliedBy(CGFloat.multipliedBy03)
            make.height.equalTo(profileImage.snp.width)
        }
        changeButton.snp.makeConstraints { make in
            make.width.equalTo(CGFloat.buttonWidth)
            make.height.equalTo(CGFloat.buttonHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom)
        }
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.textFieldOffset)
            make.right.equalToSuperview().inset(CGFloat.textFieldOffset)
            make.height.equalTo(CGFloat.buttonHeight)
            make.top.equalTo(changeButton.snp.bottom).offset(CGFloat.textFieldOffset)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(CGFloat.collectionViewOffset)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(createButton.snp.top)
        }
        createButton.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.buttonHeight)
            make.left.equalToSuperview().offset(CGFloat.buttonOffset)
            make.right.equalToSuperview().inset(CGFloat.buttonOffset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(CGFloat.buttonOffset)
        }
    }
    private func setupCollectionView(){
        collectionView.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: "\(AddCollectionViewCell.self)")
        collectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: "\(HeaderCollectionView.self)", withReuseIdentifier: "\(HeaderCollectionView.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func transform(_ anim: UICollectionViewCell, _ reverse: UICollectionViewCell) {
        if anim != reverse {
            UIView.animate(withDuration: 0.2) {
                anim.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                anim.layer.borderWidth = 1
                reverse.transform = .identity
                reverse.layer.borderWidth = 0
            }
        }
    }
    @objc private func changePhotoTapped(){
        
    }
    @objc private func createTapped(){
        
    }
}

extension AddVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: "\(HeaderCollectionView.self)", withReuseIdentifier: "\(HeaderCollectionView.self)", for: indexPath) as? HeaderCollectionView else { return UICollectionReusableView() }
            header.setupHeader(title: "Choose your plane: ")
            return header
        default:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: "\(HeaderCollectionView.self)", withReuseIdentifier: "\(HeaderCollectionView.self)", for: indexPath) as? HeaderCollectionView else { return UICollectionReusableView() }
            header.setupHeader(title: "Where would you fly?")
            return header
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return viewModel.playerArray.count
        default :
            return viewModel.backgroundArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AddCollectionViewCell.self)", for: indexPath) as? AddCollectionViewCell else { return UICollectionViewCell()}
            let item = viewModel.playerArray[indexPath.row]
            cell.setupCell(imageString: item)
            if indexPath.row == 0 {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut){
                    cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    cell.layer.borderWidth = 1
                }
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AddCollectionViewCell.self)", for: indexPath) as? AddCollectionViewCell else { return UICollectionViewCell()}
            let item = viewModel.backgroundArray[indexPath.row]
            cell.setupCell(imageString: item)
            if indexPath.row == 0 {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut){
                    cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    cell.layer.borderWidth = 1
                }
            }
            return cell
        }
    }
}
extension AddVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            transform(collectionView.cellForItem(at: indexPath) ?? UICollectionViewCell(), collectionView.cellForItem(at: indexPlayer) ?? UICollectionViewCell())
            indexPlayer = indexPath
        default:
            transform(collectionView.cellForItem(at: indexPath) ?? UICollectionViewCell(), collectionView.cellForItem(at: indexBackground) ?? UICollectionViewCell())
            indexBackground = indexPath
        }
    }
}

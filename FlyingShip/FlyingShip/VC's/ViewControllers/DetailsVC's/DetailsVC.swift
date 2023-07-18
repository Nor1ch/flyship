//
//  DetailsVC.swift
//  FlyingShip
//
//  Created by Nor1 on 14.07.2023.
//

import Foundation
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

protocol DetailsVCDelegate: AnyObject {
    func returnProfile(profile: Profile)
}

//MARK: - Parent ViewController for Settings and Add VC's

class DetailsVC: UIViewController {
    
    weak var delegate: DetailsVCDelegate?
    
//MARK: - let/var
   
    private var indexPlayer: IndexPath = IndexPath(row: 0, section: 0)
    private var indexBackground: IndexPath = IndexPath(row: 0, section: 1)
    private var image: String?
    private let viewModel: DetailsViewModel = DetailsViewModel()
    private var arrayOfName: [String] = []
    
//MARK: - Child Views
    
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
        config.titleAlignment = .center
        config.baseBackgroundColor = .cyan
        config.background.cornerRadius = CGFloat.cornerRadius
        config.cornerStyle = .fixed
        view.configuration = config
        view.isEnabled = false
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout.playerAndBackgroundFlow())
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()
    private lazy var textFieldName: UITextField = {
        let view = UITextField()
        view.backgroundColor = .lightGray
        view.font = Constants.Fonts.textField
        view.placeholder = "What is your name?"
        view.textAlignment = .center
        view.layer.cornerRadius = CGFloat.cornerRadius
        return view
    }()
    
//MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        setupCollectionView()
        ProfileManager.shared.profiles.forEach {
            arrayOfName.append($0.name)
        }
    }

//MARK: - private funcs
    
    private func setupViews(){
        view.addSubview(backgorundImage)
        view.addSubview(profileImage)
        view.addSubview(changeButton)
        view.addSubview(textFieldName)
        view.addSubview(createButton)
        view.addSubview(collectionView)
        textFieldName.delegate = self
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
        textFieldName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.textFieldOffset)
            make.right.equalToSuperview().inset(CGFloat.textFieldOffset)
            make.height.equalTo(CGFloat.buttonHeight)
            make.top.equalTo(changeButton.snp.bottom).offset(CGFloat.textFieldOffset)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textFieldName.snp.bottom).offset(CGFloat.collectionViewOffset)
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
    
//MARK: - animation for choosing items
    
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
    
//MARK: - ImagePicker
    
    @objc private func changePhotoTapped(){
        let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                present(picker, animated: true)
    }
    
//MARK: - setup views for child controllers
    
    func setupCreateButton(title: String, selector: Selector, isEnabled: Bool) {
        let attr : [NSAttributedString.Key: Any] = [
            .font : Constants.Fonts.createButton as Any,
            .foregroundColor : UIColor.orange as Any
        ]
        let title = title
        createButton.setAttributedTitle(NSAttributedString(string: title, attributes: attr), for: .normal)
        createButton.isEnabled = isEnabled
        createButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    func setupIndexes(profile: Profile){
        indexPlayer = IndexPath(row: viewModel.playerArray.firstIndex(of: profile.playerImage) ?? 0, section: 0)
        indexBackground = IndexPath(row: viewModel.backgroundArray.firstIndex(of: profile.backgroundImage) ?? 0, section: 1)
    }
    func setupTextField(name: String){
        textFieldName.text = name
        textFieldName.isEnabled = false
    }
    func setupImage(image: String?){
        if let image = image {
            let loadedImage = UserDefaults.standard.loadImage(fileName: image)
            if loadedImage != nil {
                profileImage.image = loadedImage
            }
        }
    }
    func takeCurrentProfile() -> Profile {
        return Profile(name: textFieldName.text ?? "", bestScore: 0, image: image, playerImage: viewModel.playerArray[indexPlayer.row], backgroundImage: viewModel.backgroundArray[indexBackground.row])
    }
    func takeCurrentProfileImages() -> (player: String, background: String, image: String?) {
        return (player: viewModel.playerArray[indexPlayer.row], background: viewModel.backgroundArray[indexBackground.row], image: image)
    }
}

//MARK: - extension collectionView data source

extension DetailsVC: UICollectionViewDataSource {
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
            if indexPath.row == indexPlayer.row {
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
            if indexPath.row == indexBackground.row {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut){
                    cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    cell.layer.borderWidth = 1
                }
            }
            return cell
        }
    }
}

//MARK: - extension collectionView delegate

extension DetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
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

//MARK: - extension image picker

extension DetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let name = UserDefaults.standard.saveImage(image: pickedImage)
            self.image = name
            profileImage.image = pickedImage
            picker.dismiss(animated: true)
        }
    }
}

//MARK: - extension textField delegate

extension DetailsVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let name = textFieldName.text {
            if name != "" && !arrayOfName.contains(name){
                createButton.isEnabled = true
            } else {
                createButton.isEnabled = false
            }
        }
    }
}


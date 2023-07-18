//
//  EntranceVC.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import SnapKit
import UIKit
import Combine

private extension CGFloat {
    static let logoOffset = 50.0
    static let tableViewOffset = 25.0
    static let rowHeight = 100.0
    static let scale095 = 0.95
}

final class EntranceVC: UIViewController {
    
//MARK: - let/var
    
    private let viewModel: EntranceViewModel
    private var canceallabel = Set<AnyCancellable>()
//MARK: - views
    
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.Images.backgroundEntrance
        view.contentMode = .scaleAspectFill
        return view
    }()
    private lazy var logoLabel: UILabel = {
        let view = UILabel()
        view.text = "FLYSHIP"
        view.font = Constants.Fonts.logoLabel
        view.textColor = .white
        view.alpha = 0
        return view
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.rowHeight = CGFloat.rowHeight
        view.backgroundColor = .clear
        view.alpha = 0
        return view
    }()
    
//MARK: - init
    
    init(viewModel: EntranceViewModel){
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
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ProfileManager.shared.currentProfile != nil {
            DispatchQueue.main.async {
                self.tableView.reloadSections([0], with: .automatic)
            }
        }
    }
    
//MARK: - private funcs
    
    private func setupViews(){
        view.addSubview(backgroundImage)
        view.addSubview(logoLabel)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EntranceTableViewCell.self, forCellReuseIdentifier: "\(EntranceTableViewCell.self)")
        tableView.register(EntranceTableViewCellADD.self, forCellReuseIdentifier: "\(EntranceTableViewCellADD.self)")
    }
    private func makeConstraints(){
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
            make.height.equalToSuperview()
        }
    }

//MARK: - animation on load
    
    private func startAnimation(){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.logoLabel.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(CGFloat.logoOffset)
            }
            self.tableView.snp.remakeConstraints { make in
                make.top.equalTo(self.logoLabel.snp.bottom).offset(CGFloat.tableViewOffset*2)
                make.left.equalToSuperview().offset(CGFloat.tableViewOffset)
                make.right.equalToSuperview().inset(CGFloat.tableViewOffset)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
            self.logoLabel.alpha = 1
            self.tableView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - extension tableView data source

extension EntranceVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.profilesArray.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EntranceTableViewCell.self)", for: indexPath) as? EntranceTableViewCell else { return UITableViewCell() }
            let item = viewModel.profilesArray[indexPath.row]
            cell.setupCell(model: item)
            cell.selectionStyle = .none
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EntranceTableViewCellADD.self)", for: indexPath) as? EntranceTableViewCellADD else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        }
    }
}

//MARK: - extension tableView delegate

extension EntranceVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                let cell = tableView.cellForRow(at: indexPath)
                cell?.transform = CGAffineTransform(scaleX: CGFloat.scale095, y: CGFloat.scale095)
            } completion: { bool in
                ProfileManager.shared.currentProfile = ProfileManager.shared.profiles[indexPath.row]
                self.viewModel.openMenu()
                tableView.cellForRow(at: indexPath)?.transform = .identity
            }
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) {
                let cell = tableView.cellForRow(at: indexPath)
                cell?.transform = CGAffineTransform(scaleX: CGFloat.scale095, y: CGFloat.scale095)
            } completion: { bool in
                self.viewModel.openAdd()
                tableView.cellForRow(at: indexPath)?.transform = .identity
            }
        }
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        true
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return true
        default:
            return false
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            self.viewModel.profilesArray.remove(at: indexPath.row)
            ProfileManager.shared.profiles.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

//MARK: - extension detailsVC delegate

extension EntranceVC: DetailsVCDelegate {
    func returnProfile(profile: Profile) {
        ProfileManager.shared.profiles.insert(profile, at: 0)
        DispatchQueue.main.async {
            self.tableView.reloadSections([0], with: .automatic)
        }
    }
}

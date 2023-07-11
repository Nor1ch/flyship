//
//  EntranceVC.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import SnapKit
import UIKit

private extension CGFloat {
    static let logoOffset = 50.0
    static let tableViewOffset = 25.0
    static let rowHeight = 100.0
}

final class EntranceVC: UIViewController {
    
    private let viewModel: EntranceViewModel = EntranceViewModel()
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
        return view
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.rowHeight = CGFloat.rowHeight
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        startAnimation()
    }
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
            self.view.layoutIfNeeded()
        }
    }
}

extension EntranceVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.testArray.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EntranceTableViewCell.self)", for: indexPath) as? EntranceTableViewCell else { return UITableViewCell() }
            let item = viewModel.testArray[indexPath.row]
            cell.setupCell(model: item)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EntranceTableViewCellADD.self)", for: indexPath) as? EntranceTableViewCellADD else { return UITableViewCell()}
            return cell
        }
    }
}
extension EntranceVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        default:
            let vc = AddVC()
            self.present(vc, animated: true, completion: nil)
        }
    }
}

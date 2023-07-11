//
//  AddVC.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//

import Foundation
import UIKit

protocol AddVCDelegate: AnyObject {
    
}

final class AddVC: UIViewController {
    
    private lazy var containerImage: UIView = {
        let view = UIView()
        view.backgroundColor = .red
    }()
    private lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    private lazy var textField: UITextField = {
        let view = UITextField()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

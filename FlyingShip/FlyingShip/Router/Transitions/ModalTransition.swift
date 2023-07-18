//
//  ModalTransition.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//
import Foundation
import UIKit

class ModalTransition : Transition {
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        viewController.modalPresentationStyle = .automatic
        if let vc = viewController as? DetailsVC, let vcFrom = from as? DetailsVCDelegate {
            vc.delegate = vcFrom
        }
        from.present(viewController, animated: true, completion: completion)
    }
    
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: true, completion: completion)
    }
}

//
//  Router.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//
import Foundation
import UIKit

protocol Closable: AnyObject {
    func close()
    func close(completion: (() -> Void)?)
}

protocol Dismissable: AnyObject {
    func dismiss()
    func dismiss(completion: (() -> Void)?)
}

protocol Routable: AnyObject {
    func route(to viewController: UIViewController, as transition: Transition)
    func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?)
}

protocol Router: Routable {
    var root: UIViewController? { get set }
}

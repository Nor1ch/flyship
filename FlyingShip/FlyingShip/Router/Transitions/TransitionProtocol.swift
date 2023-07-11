//
//  TransitionProtocol.swift
//  FlyingShip
//
//  Created by Nor1 on 11.07.2023.
//
import Foundation
import UIKit

protocol Transition: AnyObject {
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}

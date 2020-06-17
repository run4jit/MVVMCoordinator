//
//  MainCoordinater.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    class var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}

protocol Storyboard {
    static func instantiate() -> Self
}

extension Storyboard where Self: UIViewController {
    static func instantiate() -> Self  {
        return UIStoryboard.main.instantiateViewController(identifier: self.identifier) as! Self
    }
}

protocol Coordinater: class {
    var parentCoordinater: Coordinater? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinaters: [Coordinater] { get set }
    var parentVC: UIViewController? { get }
    func navigate()
    func goBackToParent()
}

extension Coordinater {
    func pushVC(_ vc: BaseViewController) {
        vc.coordinater = self
        vc.coordinater?.navigationController.pushViewController(vc, animated: true)
    }
    func popVC() {
        self.navigationController.popViewController(animated: true)
    }
    
    func childDidFinish(_ coordinater: Coordinater) {
        for (index, childCoordinater) in childCoordinaters.enumerated() {
            if coordinater === childCoordinater {
                self.childCoordinaters.remove(at: index)
                return
            }
        }
    }
    
    func goBackToParent() {
        guard let vc = parentVC else { return }
        self.navigationController.popToViewController(vc, animated: true)
        self.parentCoordinater?.childDidFinish(self)
    }
}

class BaseCoordinater: NSObject, UINavigationControllerDelegate {
    var didFinish: ((_ fromViewController: UIViewController) -> Void)?
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        didFinish?(fromViewController)
    }
    
    deinit {
        debugPrint("Coordinater: \(String(describing: self))")
    }
}

class MainCoordinater: BaseCoordinater, Coordinater {
    weak var parentVC: UIViewController?
    
    var parentCoordinater: Coordinater? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinaters = [Coordinater]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.parentVC = navigationController.topViewController
        super.init()
    }
    
    func navigate() {
        self.navigationController.delegate = self
        let vc = ViewController.instantiate()
        pushVC(vc)
    }
    
    private func setupCoordinater(_ childCoordinater : Coordinater) {
        self.childCoordinaters.append(childCoordinater)
        childCoordinater.parentCoordinater = self
    }
    
    func buyFlowSubscription() -> Coordinater {
        let childCoordinater = BuyCoordinater(navigationController: self.navigationController)
        setupCoordinater(childCoordinater)
        return childCoordinater
    }
    
    func creteProfileFlowSubscription() -> Coordinater {
        let childCoordinater = CreateAccountCoordinater(navigationController: self.navigationController)
        setupCoordinater(childCoordinater)
        return childCoordinater
    }
}


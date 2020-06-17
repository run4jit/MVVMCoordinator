//
//  CreateAccountCoordinater.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import Foundation
import UIKit

protocol SignupNavigation {
    func navigateToSignup(address: Address)
}

class CreateAccountCoordinater: BaseCoordinater, SignupNavigation, Coordinater {
    
    weak var parentVC: UIViewController?
    
    var parentCoordinater: Coordinater?
    var navigationController: UINavigationController
    
    var childCoordinaters = [Coordinater]()
    
    func navigate() {
        navigateToCreatProfile()
    }
        
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
        self.parentVC = navigationController.topViewController

        super.didFinish = {[weak self] fromViewController in
            guard let self = self, fromViewController is CreateAccountViewController else { return }
            self.parentCoordinater?.childDidFinish(self)
        }
    }
    
    func navigateToSignup(address: Address) {
        let vc = SignUpViewController.instantiate()
        vc.address = address
        vc.coordinater = self
        pushVC(vc)
    }
    
    
    func navigateToCreatProfile() {
        let vc = CreateAccountViewController.instantiate()
        vc.coordinater = self
        pushVC(vc)
    }
    
}

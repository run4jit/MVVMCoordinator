//
//  BuyCoordinater.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import Foundation
import UIKit

class BuyCoordinater: BaseCoordinater, Coordinater {
    weak var parentVC: UIViewController?
    
    var parentCoordinater: Coordinater?
    var navigationController: UINavigationController
    
    var childCoordinaters = [Coordinater]()
    
    func navigate() {
        naviateToBuyVC()
    }
    
    func naviateToBuyVC() {
        let vc = BuyViewController.instantiate()
        vc.coordinater = self
        self.pushVC(vc)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.parentVC = navigationController.topViewController
        super.init()
        self.navigationController.delegate = self
        
        super.didFinish = {[weak self] fromViewController in
            guard let self = self, fromViewController is BuyViewController else { return }
            self.parentCoordinater?.childDidFinish(self)
        }
        
    }
}

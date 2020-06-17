//
//  ViewController.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Storyboard {
    weak var coordinater: Coordinater?
    
    deinit {
           debugPrint("UIViewController: \(String(describing: self))")
       }
}

class ViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buyProductAction(_ sender: Any) {
        guard let mainCoordinater = coordinater as? MainCoordinater else { return }
        mainCoordinater.buyFlowSubscription().navigate()
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        guard let mainCoordinater = coordinater as? MainCoordinater else { return }
        mainCoordinater.creteProfileFlowSubscription().navigate()

    }
}


//
//  SignUpViewController.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    var address: Address?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint(address?.description ?? "")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func goToParentAction(_ sender: Any) {
        self.coordinater?.goBackToParent()
    }
    
}

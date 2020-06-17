//
//  CreateAccountViewController.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import UIKit

class CreateAccountViewController: BaseViewController {

    var account: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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

    
    @IBAction func signupAction(_ sender: Any) {
        guard let coordinater = self.coordinater as? CreateAccountCoordinater else {
            return
        }
        let address = account?.user.address ?? Address(street: "Kammasandra electronic city", state: "Karnataka", country: "India", pinCode: 560001)
        coordinater.navigateToSignup(address: address)
    }
}

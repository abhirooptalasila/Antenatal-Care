//
//  unverifiedViewController.swift
//  Antenatal Care
//
//  Created by student on 08/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class unverifiedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        let initialVC=self.storyboard?.instantiateViewController(identifier: Constants.BeginStoryboard.beginViewController) as? LoginViewController
        self.view.window?.rootViewController=initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

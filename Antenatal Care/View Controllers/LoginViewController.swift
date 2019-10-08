//
//  ViewController.swift
//  Antenatal Care
//
//  Created by student on 01/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

class LoginViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let vc = UIViewController()
        //vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        //self.present(vc, animated: true, completion: nil)
        
    }

    @IBAction func loginPressed(_ sender: UIButton)
    {
        let authUI=FUIAuth.defaultAuthUI()
        
        authUI?.delegate = self
        authUI?.providers=[FUIEmailAuth()]
        
        let authVC=authUI!.authViewController()
        authVC.modalPresentationStyle = .fullScreen
        present(authVC, animated: true, completion: nil)
    }
}
extension LoginViewController: FUIAuthDelegate
{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
    guard error == nil else{
        //Error is there
        return
    }
    guard let uid=authDataResult?.user.uid else{return}
    let db=Firestore.firestore()
    db.collection("Verified users").whereField("uid", isEqualTo: uid)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else
            {
                guard let querySnapshot = querySnapshot else {return}
                if querySnapshot.count > 0
                {
                    Constants.id.docid=querySnapshot.documents[0].documentID
                    let verifiedVC=self.storyboard?.instantiateViewController(identifier: Constants.verifiedStoryboard.verifiedViewControllers) as? TapNFCViewController
                    self.view.window?.rootViewController=verifiedVC
                    self.view.window?.makeKeyAndVisible()
                }
                else
                {
                    let notVerifiedVC=self.storyboard?.instantiateViewController(identifier: Constants.notVerifiedStoryboard.notVerifiedViewControllers) as? unverifiedViewController
                    self.view.window?.rootViewController=notVerifiedVC
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }

}

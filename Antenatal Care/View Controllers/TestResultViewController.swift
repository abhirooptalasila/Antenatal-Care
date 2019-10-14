//
//  TestResultViewController.swift
//  Antenatal Care
//
//  Created by student on 11/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class TestResultViewController: UIViewController {

    @IBOutlet weak var testResult: UIImageView!
    var date:String?
    var testName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let uid=Auth.auth().currentUser?.uid else{return}
        guard let date=date else{return}
        guard let testName=testName else{return}
        // Do any additional setup after loading the view.
        let placeholderImage = UIImage(named: "placeholder.jpg")
        let db=Firestore.firestore()
               
               db.collection("verified_users").whereField("uid", isEqualTo: uid)
                  .getDocuments() { (querySnapshot, err) in
                      if let err = err {
                          print("Error getting documents: \(err)")
                      } else {
                       guard let querySnapshot = querySnapshot else {
                           return
                       }
                        let docRef = db.collection("patient/\(uid)/tests/\(testName)/\(uid)").document(date)

                       docRef.getDocument { (document, error) in
                           if let document = document, document.exists {
                            guard let url=document.get("testResURL") as? String else{return}
                            self.testResult.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
                        }
                        }
                    }
        }
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

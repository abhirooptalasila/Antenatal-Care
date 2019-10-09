//
//  EditBasicDataViewController.swift
//  Antenatal Care
//
//  Created by student on 09/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase

class EditBasicDataViewController: UIViewController {

    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var mName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var add1: UITextField!
    @IBOutlet weak var add2: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var phno: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var fname:String?
               var mname:String?
               var lname:String?
               var add1:String?
               var add2:String?
               var city:String?
               var state:String?
               var zip:String?
               var phno:String?
               // Do any additional setup after loading the view.
               let db=Firestore.firestore()
               guard let uid=Auth.auth().currentUser?.uid else{return}
               db.collection("verified_users").whereField("uid", isEqualTo: uid)
                  .getDocuments() { (querySnapshot, err) in
                      if let err = err {
                          print("Error getting documents: \(err)")
                      } else {
                       guard let querySnapshot = querySnapshot else {
                           return
                       }
                       let docRef = db.collection("Patient").document(uid)

                       docRef.getDocument { (document, error) in
                           if let document = document, document.exists {
                               if document.get("first_name")==nil{
                                   self.fName.placeholder="Enter Data"
                               }
                               else{
                                   fname=document.get("first_name") as? String
                               }
                               if document.get("middle_name")==nil{
                                   self.mName.placeholder="Enter Data"
                               }
                               else{
                                   mname=document.get("middle_name") as? String
                               }
                               if document.get("last_name")==nil{
                                   self.lName.placeholder="Enter Data"
                               }
                               else{
                                   lname=document.get("last_name") as? String
                               }
                               if document.get("add1")==nil{
                                    self.add1.placeholder="Enter Data"
                                   
                               }
                               else{
                                   add1=document.get("add1") as? String
                               }
                               if document.get("add2")==nil{
                                   self.add2.placeholder="Enter Data"
                               }
                               else{
                                   add2=document.get("add2") as? String
                               }
                               if document.get("city")==nil{
                                  self.city.placeholder="Enter Data"
                               }
                               else{
                                   city=document.get("city") as? String
                               }
                               if document.get("state")==nil{
                                   self.state.placeholder="Enter Data"
                               }
                               else{
                                   state=document.get("state") as? String
                               }
                               if document.get("zip")==nil{
                                   self.zip.placeholder="Enter Data"
                               }
                               else{
                                   zip=document.get("zip") as? String
                               }
                               if document.get("phno")==nil{
                                   self.phno.placeholder="Enter Data"
                               }
                               else{
                                   phno=document.get("phno") as? String
                               }
                            if fname != ""{
                               self.fName.text=fname
                            }
                            else{
                                self.fName.placeholder="Enter Data"
                            }
                               
                            if mname != ""{
                                self.mName.text=mname
                            }
                            else{
                                self.mName.placeholder="Enter Data"
                            }
                            if lname != ""{
                                self.lName.text=lname
                            }
                            else{
                                self.lName.placeholder="Enter Data"
                            }
                            if add1 != ""{
                                self.add1.text=add1
                            }
                            else{
                                self.add1.placeholder="Enter Data"
                            }
                            if add2 != ""{
                               self.add2.text=add2
                            }
                            else{
                                self.add2.placeholder="Enter Data"
                            }
                            if city != ""{
                               self.city.text=city
                            }
                            else{
                                self.city.placeholder="Enter Data"
                            }
                            if state != ""{
                               self.state.text=state
                            }
                            else{
                                self.state.placeholder="Enter Data"
                            }
                            if zip != ""{
                                self.zip.text=zip
                            }
                            else{
                                self.zip.placeholder="Enter Data"
                            }
                            if phno != ""{
                                self.phno.text=phno
                            }
                            else{
                                self.phno.placeholder="Enter Data"
                            }
                           } else {
                               print("Document does not exist")
                           }
                       }
                          }
                     }
    }
    
    @IBAction func writePressed(_ sender: UIButton) {
        let db=Firestore.firestore()
        guard let uid=Auth.auth().currentUser?.uid else{return}
        db.collection("Verified users").whereField("uid", isEqualTo: uid)
           .getDocuments() { (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: \(err)")
               } else {
                guard let querySnapshot = querySnapshot else {
                    return
                }
                db.collection("Patient").document(uid).setData([
                    "first_name": self.fName.text,
                    "middle_name": self.mName.text,
                    "last_name": self.lName.text,
                    "add1": self.add1.text,
                    "add2": self.add2.text,
                    "city": self.city.text,
                    "state": self.state.text,
                    "zip": self.zip.text,
                    "phno": self.phno.text,
                    "uid":uid
                ],merge: true)
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

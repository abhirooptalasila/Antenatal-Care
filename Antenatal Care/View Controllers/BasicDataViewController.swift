//
//  BasicDataViewController.swift
//  Antenatal Care
//
//  Created by student on 04/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase

class BasicDataViewController: UIViewController {

    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var add1: UILabel!
    @IBOutlet weak var add2: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var phno: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
                let docRef = db.collection("Patient/\(uid)/basic_data").document(uid)

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if document.get("first_name")==nil{
                            self.fName.text="No Data"
                            self.fName.textColor=UIColor.gray
                        }
                        else{
                            fname=document.get("first_name") as? String
                        }
                        if document.get("middle_name")==nil{
                            self.mName.text="No Data"
                            self.mName.textColor=UIColor.gray
                        }
                        else{
                            mname=document.get("middle_name") as? String
                        }
                        if document.get("last_name")==nil{
                            self.lName.text="No Data"
                            self.lName.textColor=UIColor.gray
                        }
                        else{
                            lname=document.get("last_name") as? String
                        }
                        if document.get("add1")==nil{
                             self.add1.text="No Data"
                            self.add1.textColor=UIColor.gray
                            
                        }
                        else{
                            add1=document.get("add1") as? String
                        }
                        if document.get("add2")==nil{
                            self.add2.text="No Data"
                            self.add2.textColor=UIColor.gray
                        }
                        else{
                            add2=document.get("add2") as? String
                        }
                        if document.get("city")==nil{
                           self.city.text="No Data"
                            self.city.textColor=UIColor.gray
                        }
                        else{
                            city=document.get("city") as? String
                        }
                        if document.get("state")==nil{
                            self.state.text="No Data"
                            self.state.textColor=UIColor.gray
                        }
                        else{
                            state=document.get("state") as? String
                        }
                        if document.get("zip")==nil{
                            self.zip.text="No Data"
                            self.zip.textColor=UIColor.gray
                        }
                        else{
                            zip=document.get("zip") as? String
                        }
                        if document.get("phno")==nil{
                            self.phno.text="No Data"
                            self.phno.textColor=UIColor.gray
                        }
                        else{
                            phno=document.get("phno") as? String
                        }
                     if fname != ""{
                        self.fName.text=fname
                     }
                     else{
                         self.fName.text="No Data"
                         self.fName.textColor=UIColor.gray
                     }
                        
                     if mname != ""{
                         self.mName.text=mname
                     }
                     else{
                         self.mName.text="No Data"
                         self.mName.textColor=UIColor.gray
                     }
                     if lname != ""{
                         self.lName.text=lname
                     }
                     else{
                        self.lName.text="No Data"
                         self.lName.textColor=UIColor.gray
                     }
                     if add1 != ""{
                         self.add1.text=add1
                     }
                     else{
                         self.add1.text="No Data"
                         self.add1.textColor=UIColor.gray
                     }
                     if add2 != ""{
                        self.add2.text=add2
                     }
                     else{
                         self.add2.text="No Data"
                         self.add2.textColor=UIColor.gray
                        }
                     if city != ""{
                        self.city.text=city
                     }
                     else{
                         self.city.text="No Data"
                         self.city.textColor=UIColor.gray
                     }
                     if state != ""{
                        self.state.text=state
                     }
                     else{
                          self.state.text="No Data"
                        self.state.textColor=UIColor.gray
                     }
                     if zip != ""{
                         self.zip.text=zip
                     }
                     else{
                         self.zip.text="No Data"
                         self.zip.textColor=UIColor.gray
                     }
                     if phno != ""{
                         self.phno.text=phno
                     }
                     else{
                         self.phno.text="No Data"
                         self.phno.textColor=UIColor.gray
                     }
                    } else {
                        print("Document does not exist")
                        self.fName.text="No Data"
                        self.fName.textColor=UIColor.gray
                        self.mName.text="No Data"
                        self.mName.textColor=UIColor.gray
                        self.lName.text="No Data"
                        self.lName.textColor=UIColor.gray
                        self.add1.text="No Data"
                        self.add1.textColor=UIColor.gray
                        self.add2.text="No Data"
                        self.add2.textColor=UIColor.gray
                        self.city.text="No Data"
                        self.city.textColor=UIColor.gray
                        self.state.text="No Data"
                        self.state.textColor=UIColor.gray
                        self.zip.text="No Data"
                        self.zip.textColor=UIColor.gray
                        self.phno.text="No Data"
                        self.phno.textColor=UIColor.gray
                    }
                }
                   }
              }
    }
    
    @IBAction func unwindtoBasicData(unwindSegue:UIStoryboardSegue){
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
                let docRef = db.collection("Patient/\(uid)/basic_data").document(uid)

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if document.get("first_name")==nil{
                            self.fName.text="No Data"
                            self.fName.textColor=UIColor.gray
                        }
                        else{
                            fname=document.get("first_name") as? String
                        }
                        if document.get("middle_name")==nil{
                            self.mName.text="No Data"
                            self.mName.textColor=UIColor.gray
                        }
                        else{
                            mname=document.get("middle_name") as? String
                        }
                        if document.get("last_name")==nil{
                            self.lName.text="No Data"
                            self.lName.textColor=UIColor.gray
                        }
                        else{
                            lname=document.get("last_name") as? String
                        }
                        if document.get("add1")==nil{
                             self.add1.text="No Data"
                            self.add1.textColor=UIColor.gray
                            
                        }
                        else{
                            add1=document.get("add1") as? String
                        }
                        if document.get("add2")==nil{
                            self.add2.text="No Data"
                            self.add2.textColor=UIColor.gray
                        }
                        else{
                            add2=document.get("add2") as? String
                        }
                        if document.get("city")==nil{
                           self.city.text="No Data"
                            self.city.textColor=UIColor.gray
                        }
                        else{
                            city=document.get("city") as? String
                        }
                        if document.get("state")==nil{
                            self.state.text="No Data"
                            self.state.textColor=UIColor.gray
                        }
                        else{
                            state=document.get("state") as? String
                        }
                        if document.get("zip")==nil{
                            self.zip.text="No Data"
                            self.zip.textColor=UIColor.gray
                        }
                        else{
                            zip=document.get("zip") as? String
                        }
                        if document.get("phno")==nil{
                            self.phno.text="No Data"
                            self.phno.textColor=UIColor.gray
                        }
                        else{
                            phno=document.get("phno") as? String
                        }
                     if fname != ""{
                        self.fName.text=fname
                     }
                     else{
                         self.fName.text="No Data"
                         self.fName.textColor=UIColor.gray
                     }
                        
                     if mname != ""{
                         self.mName.text=mname
                     }
                     else{
                         self.mName.text="No Data"
                         self.mName.textColor=UIColor.gray
                     }
                     if lname != ""{
                         self.lName.text=lname
                     }
                     else{
                        self.lName.text="No Data"
                         self.lName.textColor=UIColor.gray
                     }
                     if add1 != ""{
                         self.add1.text=add1
                     }
                     else{
                         self.add1.text="No Data"
                         self.add1.textColor=UIColor.gray
                     }
                     if add2 != ""{
                        self.add2.text=add2
                     }
                     else{
                         self.add2.text="No Data"
                         self.add2.textColor=UIColor.gray                     }
                     if city != ""{
                        self.city.text=city
                     }
                     else{
                         self.city.text="No Data"
                         self.city.textColor=UIColor.gray
                     }
                     if state != ""{
                        self.state.text=state
                     }
                     else{
                          self.state.text="No Data"
                        self.state.textColor=UIColor.gray
                     }
                     if zip != ""{
                         self.zip.text=zip
                     }
                     else{
                         self.zip.text="No Data"
                         self.zip.textColor=UIColor.gray
                     }
                     if phno != ""{
                         self.phno.text=phno
                     }
                     else{
                         self.phno.text="No Data"
                         self.phno.textColor=UIColor.gray
                     }
                    } else {
                        print("Document does not exist")
                        self.fName.text="No Data"
                        self.fName.textColor=UIColor.gray
                        self.mName.text="No Data"
                        self.mName.textColor=UIColor.gray
                        self.lName.text="No Data"
                        self.lName.textColor=UIColor.gray
                        self.add1.text="No Data"
                        self.add1.textColor=UIColor.gray
                        self.add2.text="No Data"
                        self.add2.textColor=UIColor.gray
                        self.city.text="No Data"
                        self.city.textColor=UIColor.gray
                        self.state.text="No Data"
                        self.state.textColor=UIColor.gray
                        self.zip.text="No Data"
                        self.zip.textColor=UIColor.gray
                        self.phno.text="No Data"
                        self.phno.textColor=UIColor.gray
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

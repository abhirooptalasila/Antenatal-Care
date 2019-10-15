//
//  AddTestsTableViewController.swift
//  Antenatal Care
//
//  Created by student on 10/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase

class AddTestsTableViewController: UITableViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var currDate: UIDatePicker!
    @IBOutlet weak var testName: UITextField!
        @IBOutlet weak var nextDate: UIDatePicker!
        var imagePicker:UIImagePickerController!
    private var picURL:String=""
        override func viewDidLoad() {
            super.viewDidLoad()

            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
            
        }


    @IBAction func backPressed(_ sender: UIButton) {
        let db=Firestore.firestore()
        guard let uid=Auth.auth().currentUser?.uid else{return}
        
        let dateFormat=DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .none
        dateFormat.locale=Locale(identifier: "en_IN")
        let currDateInString=dateFormat.string(from: currDate.date)
    
        if testName.text != ""{
            guard let testName = testName.text else { return }
            let testresRef = Storage.storage().reference().child("patient/\(uid)/tests/\(testName)/\(currDateInString)")
        testresRef.delete { error in
            if error != nil {
            // Uh-oh, an error occurred!
          } else {
            // File deleted successfully
          }
        }
        
            db.collection("patient/\(uid)/tests/\(testName)/\(uid)").document(currDateInString).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        }
    }
    @IBAction func writePressed(_ sender: UIButton) {
            let dateFormat=DateFormatter()
            dateFormat.dateStyle = .medium
            dateFormat.timeStyle = .none
            dateFormat.locale=Locale(identifier: "en_IN")
            let currDateInString=dateFormat.string(from: currDate.date)
            let nextDateInString=dateFormat.string(from: nextDate.date)
        
            let db=Firestore.firestore()
            guard let uid=Auth.auth().currentUser?.uid else{return}
        
            db.collection("verified_users").whereField("uid", isEqualTo: uid)
               .getDocuments() { (querySnapshot, err) in
                   if let err = err {
                       print("Error getting documents: \(err)")
                   } else {
                    guard querySnapshot != nil else {
                        return
                    }
                    if let testName=self.testName.text{
                        if self.picURL != "" {
                                db.collection("patient/\(uid)/tests/\(testName)/\(uid)").document(currDateInString).setData([
                                        "Name":testName,
                                        "Test Date":currDateInString,
                                        "Next Date":nextDateInString,
                                        "testResURL": self.picURL,
                                        "uid":uid
                                ],merge: true)
                        }
                        else{
                            db.collection("patient/\(uid)/tests/\(testName)/\(uid)").document(currDateInString).setData([
                                    "Name":testName,
                                    "Test Date":currDateInString,
                                    "Next Date":nextDateInString,
                                    "testResURL": "No image",
                                    "uid":uid
                            ],merge: true)
                        }
                    db.collection("patient/\(uid)/tests/").document(testName).setData(["uid":uid])
                    }
                }
            }
        }
        func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                imagePicker=UIImagePickerController()
                imagePicker.allowsEditing=true
                imagePicker.sourceType = .camera
                imagePicker.delegate=self
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        func openGallary()
        {
            imagePicker=UIImagePickerController()
            imagePicker.allowsEditing=true
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate=self
            self.present(imagePicker, animated: true, completion: nil)
        }
        @IBAction func addPressed(_ sender: UIButton) {
            self.addButton.isUserInteractionEnabled = true

            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))

            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.openGallary()
            }))

            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

            /*If you want work actionsheet on ipad
            then you have to use popoverPresentationController to present the actionsheet,
            otherwise app will crash on iPad */
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender
                alert.popoverPresentationController?.sourceRect = sender.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }

            self.present(alert, animated: true, completion: nil)
        }
        
    }

    extension AddTestsTableViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil  )
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let uid=Auth.auth().currentUser?.uid else{return}
            if let pickedImage=info[.editedImage] as? UIImage{
                // Create a root reference
                let storageRef = Storage.storage().reference()
                
                
                // Data in memory
               guard let data = pickedImage.jpegData(compressionQuality: 0.75) else { return }
                //0 is max compression,min quality 1 is min compression,max quality
                
                let dateFormat=DateFormatter()
                dateFormat.dateStyle = .medium
                dateFormat.timeStyle = .none
                dateFormat.locale=Locale(identifier: "en_IN")
                let currDateInString=dateFormat.string(from: currDate.date)
                
                // Create a reference to the file you want to upload
                guard let testName=testName.text else{return}
                let testresRef = storageRef.child("patient/\(uid)/tests/\(testName)/\(currDateInString)")


                // Upload the file to the path "images/rivers.jpg"
                let uploadTask = testresRef.putData(data, metadata: nil) { (metadata, error) in
                  guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                  }
                  // Metadata contains file metadata such as size, content-type.
                  let size = metadata.size
                  // You can also access to download URL after upload.
                  testresRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      // Uh-oh, an error occurred!
                      return
                    }
                    let db=Firestore.firestore()
                    guard let uid=Auth.auth().currentUser?.uid else{return}
                    db.collection("verified_users").whereField("uid", isEqualTo: uid)
                       .getDocuments() { (querySnapshot, err) in
                           if let err = err {
                               print("Error getting documents: \(err)")
                           } else {
                            guard querySnapshot != nil else {
                                return
                            }
                            if let testName=self.testName.text{
                                //db.collection("Patient/\(uid)/Tests").document(testName).setData(["testResURL": downloadURL.absoluteString],merge: true)
                                self.picURL=downloadURL.absoluteString
                                self.addButton.setImage(nil, for: UIControl.State.normal)
                                self.addButton.setTitle("Added.Tap to edit.", for: UIControl.State.normal)
                            }
                            else{
                                print("Enter test name")
                                self.addButton.setTitle("Couldn't add. Tap again to add.", for: UIControl.State.normal)
                            }
                        }
                    }
                  }
                }
                    
            }
            picker.dismiss(animated: true, completion: nil)

        }
    }

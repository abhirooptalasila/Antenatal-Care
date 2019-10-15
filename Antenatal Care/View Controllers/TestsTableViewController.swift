//
//  TestsTableViewController.swift
//  Antenatal Care
//
//  Created by student on 10/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase
class TestsTableViewController: UITableViewController {


    @IBOutlet weak var editButton: UIButton!
    private var buttonImage:UIImage!
    private var flag:Int=0
    var tests:[String]=[]

        private func loadFirebaseTests(){
            let db=Firestore.firestore()
            guard let uid=Auth.auth().currentUser?.uid else{return}
                       db.collection("patient/\(uid)/tests").whereField("uid", isEqualTo: uid)
                          .getDocuments() { (querySnapshot, err) in
                              if let err = err {
                                  print("Error getting documents: \(err)")
                              } else {
                               guard let querySnapshot = querySnapshot else {
                                   return
                               }
                                self.tests=[]
                                for doc in querySnapshot.documents{
                                    self.tests.append(doc.documentID)
                                }
                                
                        }
                            self.tableView.reloadData()
                            self.refreshControl?.endRefreshing()
            }
    }
    @objc func refresh(sender:AnyObject)
    {
        
        loadFirebaseTests()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFirebaseTests()
        tableView.refreshControl=UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
    //}
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as! TestsTableViewCell
        let test = tests[indexPath.row]
        cell.testNameLabel.text=test
        cell.showsReorderControl = true
        
        return cell
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        
        if self.editButton.currentTitle=="Done"{
            self.editButton.setTitle("Edit", for: UIControl.State.normal)
            self.editButton.setImage(buttonImage, for: UIControl.State.normal)
        }
        if self.editButton.currentTitle=="Edit" && flag==0{
        buttonImage=self.editButton.currentImage
        self.editButton.setImage(nil, for: UIControl.State.normal)
        self.editButton.setTitle("Done", for: UIControl.State.normal)
            flag=1
        }
        
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name=tests[indexPath.row]
            tests.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let db=Firestore.firestore()
            guard let uid=Auth.auth().currentUser?.uid else{return}
            
            db.collection("patient/\(uid)/tests/\(name)/\(uid)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
             guard let querySnapshot = querySnapshot else {
                 return
             }
                for doc in querySnapshot.documents{
        db.collection("patient/\(uid)/tests/\(name)/\(uid)").document(doc.documentID).delete()
                    let testresRef = Storage.storage().reference().child("patient/\(uid)/tests/\(name)/\(doc.documentID)")
                    testresRef.delete { error in
                        if error != nil {
                        // Uh-oh, an error occurred!
                      } else {
                        // File deleted successfully
                      }
                    }
                }
                }
            }
            
            db.collection("patient/\(uid)/tests").document(name).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
     @IBAction func unwindtoTestList(unwindSegue: UIStoryboardSegue){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showDate"{
            let indexPath=tableView.indexPathForSelectedRow!
            let test=tests[indexPath.row]
            let destVC=segue.destination as? DateListTableViewController
            destVC?.testName=test
        }
    }

}

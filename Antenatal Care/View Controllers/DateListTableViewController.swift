//
//  DateListTableViewController.swift
//  Antenatal Care
//
//  Created by student on 11/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import Firebase

class DateListTableViewController: UITableViewController {

    @IBOutlet weak var editButton: UIButton!
    var testName:String?
    var dates:[String]=[]

        private func loadFirebaseDates(){
            let db=Firestore.firestore()
            guard let uid=Auth.auth().currentUser?.uid else{return}
            guard let testName=testName else{return}
            db.collection("patient/\(uid)/tests/\(testName)/\(uid)").whereField("uid", isEqualTo: uid)
                          .getDocuments() { (querySnapshot, err) in
                              if let err = err {
                                  print("Error getting documents: \(err)")
                              } else {
                               guard let querySnapshot = querySnapshot else {
                                   return
                               }
                                self.dates=[]
                                for doc in querySnapshot.documents{
                                    self.dates.append(doc.documentID)
                                }
                                
                        }
                            self.tableView.reloadData()
                            self.refreshControl?.endRefreshing()
            }
    }
    @objc func refresh(sender:AnyObject)
    {
        
        loadFirebaseDates()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFirebaseDates()
        tableView.refreshControl=UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    // MARK: - Table view data source


    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! DateListTableViewCell
        let date = dates[indexPath.row]
        cell.dateLabel.text=date
        cell.showsReorderControl = true
        
        return cell
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        self.editButton.setImage(nil, for: UIControl.State.normal)
        self.editButton.setTitle("Done", for: UIControl.State.normal)
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let date=dates[indexPath.row]
            dates.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let db=Firestore.firestore()
            guard let uid=Auth.auth().currentUser?.uid else{return}
            guard let testName=testName else{return}
            db.collection("patient/\(uid)/tests/\(testName)/\(uid)").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                 guard let querySnapshot = querySnapshot else {
                     return
                 }
                    for doc in querySnapshot.documents{
                        if doc.documentID==date{
                                db.collection("patient/\(uid)/tests/\(testName)/\(uid)").document(doc.documentID).delete()
                        }
                    }
                    }
                }
            let testresRef = Storage.storage().reference().child("patient/\(uid)/tests/\(testName)/\(date)")
                   testresRef.delete { error in
                     if let error = error {
                       // Uh-oh, an error occurred!
                     } else {
                       // File deleted successfully
                     }
                   }
            }
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let date = dates[indexPath.row]
        let destinationVC=TestResultViewController()
        guard let testName=testName else{return}
        destinationVC.testName=testName
        destinationVC.date=date
        performSegue(withIdentifier: "showResult", sender: self)
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
     @IBAction func unwindtoDateList(unwindSegue: UIStoryboardSegue){
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showResult"{
            let indexPath=tableView.indexPathForSelectedRow!
            guard let testName=testName else{return}
            let date=dates[indexPath.row]
            let destVC=segue.destination as? TestResultViewController
            destVC?.testName=testName
            destVC?.date=date
        }
    }
}

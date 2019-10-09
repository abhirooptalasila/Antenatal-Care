//
//  basicDataTableViewController.swift
//  Antenatal Care
//
//  Created by student on 09/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class basicDataTableViewController: UITableViewController {

    var data:[String] = ["Patient's Name","Patient ID","Husband's Name","Current Address","Permanent Address","Date Of Birth","Phone Number","Alternate Phone Number","Hospital Name","Hospital ID","Last Menstrual Date","Feta's Weight","Patient's Weight","Feta's Heartrate","Patient's Heartrate","Remarks"];
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicData",for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

}

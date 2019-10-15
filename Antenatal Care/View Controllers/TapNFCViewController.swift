//
//  TapNFCViewController.swift
//  Antenatal Care
//
//  Created by student on 04/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import CoreNFC

class TapNFCViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    @IBOutlet weak var messageLabel: UIButton!
    var nfcsession:NFCNDEFReaderSession?
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be disposed
    }
    
    @IBAction func scanPressed(_ sender: Any) {
        nfcsession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: ((nfcsession?.begin()) != nil))
        performSegue(withIdentifier: "scanSuccessful", sender: self)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    //when this is called you'll get an array of detected messages
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .ascii) {
                    print(string)
                }
            }
        }
    }
    @IBAction func unwindToTapNFC(unwindsegue:UIStoryboardSegue){
        
    }

}

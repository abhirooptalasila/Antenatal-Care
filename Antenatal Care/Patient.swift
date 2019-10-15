//
//  Patient.swift
//  Antenatal Care
//
//  Created by student on 03/10/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

struct basicData {
    let patientName: String?
    let patientID: Int
    let husbandName: String?
    let currentAddress: String?
    let permanentAddress: String?
    let dob: Date?
    let phoneNumber: String?
    let phoneNumberAlternate: String?
    let hospitalName: String?
    let lastMenstrualDate: Date?
    var fetalWeight: Double?
    var patientWeight: Double?
    var fetalHR: String?
    var patientHR: String?
    var remarks: String?
    
    let monthsToAdd = 9
    let daysToAdd = 7
    //var estimatedDeliveryDate = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: )
    //estimatedDeliveryDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: newDate!)
    
}

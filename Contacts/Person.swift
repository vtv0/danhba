//
//  ArrContact.swift
//  Contacts
//
//  Created by Vuong The Vu on 08/08/2022.
//

import Foundation

class Person: NSObject, NSCopying {
    public var ID: String
    public var Images: String
    public var Name: String
    public var PhoneNumber: [PhoneRow]  = [
        PhoneRow(phoneNumber: "", phoneType: "mobile", displayStatus: true),
        PhoneRow(phoneNumber: "", phoneType: "home", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "company", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "school", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "main", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "company fax", displayStatus: false)
    ]
    public var Email: String
    public var Company: String
    public var DateOfBirth: String
    
    init( id: String, images: String, name: String, phoneNumber: [PhoneRow], email: String, company: String, dateOfBirth: String) {
        self.ID = id
        self.Images = images
        self.Name = name
        for item:PhoneRow in phoneNumber {
            let currentPhoneRow = self.PhoneNumber.filter({$0.PhoneType == item.PhoneType}).first
            if currentPhoneRow != nil {
                currentPhoneRow?.PhoneNumber = item.PhoneNumber
                currentPhoneRow?.DisplayStatus = item.DisplayStatus
            }
        }
        
        self.Email = email
        self.Company = company
        self.DateOfBirth = dateOfBirth
    }
    //var PhoneRowDuplicate = PhoneRow.copy()
    init( id: String, images: String, name: String, email: String, company: String, dateOfBirth: String) {
        self.ID = id
        self.Images = images
        self.Name = name
        
        self.Email = email
        self.Company = company
        self.DateOfBirth = dateOfBirth
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Person(id: ID, images: Images, name: Name, phoneNumber: PhoneNumber, email: Email, company: Company, dateOfBirth: DateOfBirth)
    }
}

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
        PhoneRow(phoneNumber: "", phoneType: "di động", displayStatus: true),
        PhoneRow(phoneNumber: "", phoneType: "nhà", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "công ty", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "trường học", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "chính", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "fax công ty", displayStatus: false)
    ]
    public var Email: String
    public var Company: String
    public var DateOfBirth: String
    
    init( id: String, images: String, name: String, phoneNumber: [PhoneRow], email: String, company: String, dateOfBirth: String) {
        self.ID = id
        self.Images = images
        self.Name = name
        self.PhoneNumber = []
        for item in phoneNumber {
            self.PhoneNumber.append(item.copy() as! PhoneRow)
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

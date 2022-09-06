//
//  AssetMH3.swift
//  Contacts
//
//  Created by Vuong The Vu on 24/08/2022.
//

import Foundation


class PhoneRow {
    public var PhoneNumber : String
    public var PhoneType : String
    public var DisplayStatus : Bool = false
    
    init(phoneNumber: String , phoneType: String, displayStatus: Bool) {
        self.PhoneNumber = phoneNumber
        self.PhoneType = phoneType
        self.DisplayStatus = displayStatus
    }
    
}

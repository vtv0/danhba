//
//  AssetMH3.swift
//  Contacts
//
//  Created by Vuong The Vu on 24/08/2022.
//

import Foundation


class PhoneRow : NSObject , NSCopying {
    public var PhoneNumber : String
    public var PhoneType : String
    public var DisplayStatus : Bool = false
    
    
    init(phoneNumber: String , phoneType: String, displayStatus: Bool) {
        self.PhoneNumber = phoneNumber
        self.PhoneType = phoneType
        self.DisplayStatus = displayStatus
    }
 
    init(phoneNumber: String , phoneType: String) {
        self.PhoneNumber = phoneNumber
        self.PhoneType = phoneType
    }
    
    func copy(with zone : NSZone? = nil) -> Any {
        return PhoneRow(phoneNumber: PhoneNumber, phoneType: PhoneType, displayStatus: DisplayStatus)
    }
}

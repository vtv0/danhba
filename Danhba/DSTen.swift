//
//  DSTen.swift
//  Danhba
//
//  Created by Vuong The Vu on 20/07/2022.
//

import Foundation
struct DSTen {
    let ten : String
    let sdt : String

 
    static func GetAllDS() -> [DSTen] {
        return [
            DSTen(ten: "An",    sdt: "032222111"),
            DSTen(ten: "Ba",    sdt: "032333355"),
            DSTen(ten: "Vu",    sdt: "087364675"),
            DSTen(ten: "Van",   sdt: "099999991"),
            DSTen(ten: "thu",   sdt: "035555555"),
            DSTen(ten: "chau",  sdt: "035555777"),
            DSTen(ten: "Anh",   sdt: "098733333")
        ]
    }
}

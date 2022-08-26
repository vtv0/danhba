//
//  CellDetail.swift
//  Contacts
//
//  Created by Vuong The Vu on 25/08/2022.
//

import UIKit

class CellDetail: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPhoneType: UILabel!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
   
    @IBOutlet weak var lblEmail: UILabel!
    
   
    @IBOutlet weak var lblCompany: UILabel!
    
    @IBOutlet weak var lblDOB: UILabel!
    
    @IBOutlet weak var lblID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

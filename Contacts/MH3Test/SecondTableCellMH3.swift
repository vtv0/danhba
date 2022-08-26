//
//  SecondTableCellMH3.swift
//  Contacts
//
//  Created by Vuong The Vu on 23/08/2022.
//

import UIKit

class SecondTableCellMH3: UITableViewCell {
    
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var lblPhoneAddress: UILabel!
    
    
    @IBAction func btnDELETE(_ sender: UIButton) {
        
    }
    
    var phoneAddress:[String] = ["nha" , "truong" , "cho"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
}

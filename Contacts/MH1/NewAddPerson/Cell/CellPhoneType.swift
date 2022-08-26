//
//  CellPhoneType.swift
//  Contacts
//
//  Created by Vuong The Vu on 25/08/2022.
//

import UIKit

class CellPhoneType: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var lblPhoneType: UILabel!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

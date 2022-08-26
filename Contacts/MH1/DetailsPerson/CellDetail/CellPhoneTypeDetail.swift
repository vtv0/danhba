//
//  CellPhoneTypeDetail.swift
//  Contacts
//
//  Created by Vuong The Vu on 25/08/2022.
//

import UIKit

class CellPhoneTypeDetail: UITableViewCell {

    @IBOutlet weak var lblPhoneType: UILabel!
    
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

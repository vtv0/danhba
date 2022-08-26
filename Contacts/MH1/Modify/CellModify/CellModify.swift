//
//  CellModify.swift
//  Contacts
//
//  Created by Vuong The Vu on 26/08/2022.
//

import UIKit

class CellModify: UITableViewCell {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtCompany: UITextField!
    
    @IBOutlet weak var txtDOB: UITextField!
    
    @IBOutlet weak var txtID: UITextField!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

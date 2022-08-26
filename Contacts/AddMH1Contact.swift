//
//  AddMH1Contact.swift
//  Contacts
//
//  Created by Vuong The Vu on 18/08/2022.
//

import UIKit

class AddMH1Contact: UIViewController {
    
    @IBOutlet weak var imgHinh: UIImageView!
    
    @IBAction func btnHuyAddContact(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnXongAddContact(_ sender: Any) {
        
    }
    
    @IBAction func btnMHAddImage(_ sender: Any) {
        
    }
    
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    var item: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtID.text = item?.ID
        //imgHinh.image = UIImage(named: "")
        txtName.text = item?.Name
    }
    
    
    
    
}

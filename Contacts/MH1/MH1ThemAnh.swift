//
//  MH1ThemAnh.swift
//  Contacts
//
//  Created by Vuong The Vu on 18/08/2022.
//

import UIKit

class MH1ThemAnh: UIViewController {
    
    @IBAction func btnHuyThemAnh(_ sender: Any) {
    }
    
    @IBAction func btnThemXongAnh(_ sender: Any) {
    }
    
    @IBOutlet weak var imgHinh: UIImageView!
    
    @IBOutlet weak var txtTenAnh: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgHinh.image = UIImage(named: "anh3")
        
        imgHinh.image = UIImage(named: "anh1")
        imgHinh.layer.cornerRadius = imgHinh.frame.size.width / 2
        imgHinh.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    

    

}

//
//  AddimgDetailMH1.swift
//  Contacts
//
//  Created by Vuong The Vu on 18/08/2022.
//

import UIKit

class AddimgDetailMH1: UIViewController {
    
    @IBAction func btnHuyAddImage(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnXongAddImage(_ sender: Any) {
        
    }
    
    var item: Person!
    
    @IBOutlet weak var imgHinhDetail: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imgHinhDetail.image = UIImage(named: "anh3")
        
        imgHinhDetail.image = UIImage(named: "anh1")
        imgHinhDetail.layer.cornerRadius = imgHinhDetail.frame.size.width / 2
        imgHinhDetail.clipsToBounds = true
        
    }
    
    
    
    

    

}

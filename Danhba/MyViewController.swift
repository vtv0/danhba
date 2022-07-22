//
//  MyViewController.swift
//  Danhba
//
//  Created by Vuong The Vu on 22/07/2022.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var HTName: UILabel!
    @IBOutlet weak var hienthiSDT: UILabel!
    
    var item: MenuItem!
    
    @IBAction func QuaylaiMH1(_ sender: Any) {
        let scr = storyboard?.instantiateViewController(withIdentifier: "MH1") as! ViewController
        navigationController?.pushViewController(scr, animated: true)
       // present(scr, animated: true, completion: nil)
    }
    //    @IBAction func quaylaiMHchinh(_ sender: Any) {
//        let scr = storyboard?.instantiateViewController(withIdentifier: "MH1") as! ViewController
//        navigationController?.pushViewController(scr, animated: true)
//
//
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HTName.text = item.name
        hienthiSDT.text = item.sdt
        
    }
    

    

}

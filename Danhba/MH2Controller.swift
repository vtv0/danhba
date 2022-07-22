//
//  MH2Controller.swift
//  Danhba
//
//  Created by Vuong The Vu on 19/07/2022.
//

import UIKit


class MH2Controller: UIViewController {
    
   
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    let countryNameArr = [ "vietnam", "lao", "campuchia","nhatban", "hanxeng" , "tau", "thailan"]

    
    @IBAction func BackLienhe(_ sender: Any) {
        let scr = storyboard?.instantiateViewController(withIdentifier: "MH1") as! ViewController
        
        //navigationController?.pushViewController(scr, animated: true)
        present(scr, animated: true, completion: nil)
    }
    //    @IBAction func BackLienhe(_ sender: Any) {
//        let scr = storyboard?.instantiateViewController(withIdentifier: "MH1") as! ViewController
//
//        navigationController?.pushViewController(scr, animated: true)
//
//    }
//    @IBAction func btnLienhe(_ sender: Any) {
//        let scr = storyboard?.instantiateViewController(withIdentifier: "MH1") as! ViewController
//        present(scr, animated: true, completion: nil)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



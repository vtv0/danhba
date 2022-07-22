//
//  ViewController.swift
//  Danhba
//
//  Created by Vuong The Vu on 19/07/2022.
//

import UIKit

struct MenuItem {
    var name: String
    var sdt : String
}


class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //@IBOutlet weak var onClickShow: UIView!
    
    let arrayDS = [
        MenuItem(name: "an", sdt: "222222"),
        MenuItem(name: "ba", sdt: "333333"),
        MenuItem(name: "lan", sdt: "77777"),
        MenuItem(name: "long", sdt: "99999")
        ]
    var searchDS = [MenuItem]()
    
//    @IBAction func BackGanday(_ sender: Any) {
//        let scr = storyboard?.instantiateViewController(withIdentifier: "MH2") as! MH2Controller
//        navigationController?.pushViewController(scr, animated: true)
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchDS = arrayDS
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    
    }
    
    //hien thi ra so hang tuong ung voi so phan tu cua mang
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchDS.count
    }
    
    //hiển thị dữ liệu cho từng cái
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell =  tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            
        }
        
        let item = searchDS[indexPath.row]
        
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = item.sdt
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MyViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)  {
         
            vc.item = searchDS[indexPath.row]
        }
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchDS = arrayDS
        } else {
            searchDS = arrayDS.filter({ item
                in
                return item.name.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
}



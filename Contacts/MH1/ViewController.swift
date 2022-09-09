//
//  ViewController.swift
//  Contacts
//
//  Created by Vuong The Vu on 19/07/2022.
//

import UIKit

//protocol UpdateContactAfterProtocol: class {
//    func classListUpdate( with detailPerson: Person)
//    
//    func classListUpdate2( with detailPerson: Person) -> Bool
//}

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    var DSTen:[Person] = [
        Person(id: "0", images: "", name: "nhu", phoneNumber: [PhoneRow(phoneNumber: "0000", phoneType: "mobile", displayStatus: true)], email: "nhu000@.com", company: "aa", dateOfBirth:  "08/08/2022"),
        Person(id: "1", images: "", name: "lan", phoneNumber: [PhoneRow(phoneNumber: "0011", phoneType: "home", displayStatus: true)], email: "lan111@.com", company: "bb", dateOfBirth: "07/08/2022"),
        Person(id: "2", images: "", name: "an", phoneNumber: [PhoneRow(phoneNumber: "0022", phoneType: "main", displayStatus: true)], email: "ba0@333.com", company: "baba0", dateOfBirth: "04/08/2022"),
        Person(id: "3", images: "", name: "ba", phoneNumber: [PhoneRow(phoneNumber: "0033", phoneType: "company", displayStatus: true)], email: "ba1@333.com", company: "baba1", dateOfBirth: "24/08/2022"),
        Person(id: "4", images: "", name: "nang", phoneNumber: [PhoneRow(phoneNumber: "0044", phoneType: "mobile", displayStatus: true)], email: "ba2@333.com", company: "baba2", dateOfBirth: "14/08/2022"),
        Person(id: "5", images: "", name: "bang", phoneNumber: [PhoneRow(phoneNumber: "0055", phoneType: "mobile", displayStatus: true)], email: "ba3@333.com", company: "baba3" , dateOfBirth: "04/08/2022"),
        Person(id: "6", images: "", name: "tu", phoneNumber: [PhoneRow(phoneNumber: "0066", phoneType: "mobile", displayStatus: true)], email: "ba4@333.com", company: "baba4", dateOfBirth: "04/08/2022"),
        Person(id: "7", images: "", name: "tung", phoneNumber: [PhoneRow(phoneNumber: "0077", phoneType: "home", displayStatus: true)], email: "ba5@333.com", company: "baba5", dateOfBirth: "04/08/2022"),
        Person(id: "8", images: "", name: "ha", phoneNumber: [PhoneRow(phoneNumber: "0088", phoneType: "company", displayStatus: true)], email: "ha@010.com", company: "b1b1", dateOfBirth: "01/08/2022"),
        Person(id: "9", images: "", name: "hang", phoneNumber: [PhoneRow(phoneNumber: "0099", phoneType: "home", displayStatus: true)], email: "bon@444.com", company: "bbb", dateOfBirth: "04/08/2022"),
        Person(id: "10", images: "", name: "hung", phoneNumber: [PhoneRow(phoneNumber: "1010", phoneType: "home", displayStatus: true)], email: "nam55@.com", company: "nnn", dateOfBirth: "02/08/2022"),
        Person(id: "11", images: "", name: "linh", phoneNumber: [PhoneRow(phoneNumber: "1111", phoneType: "school", displayStatus: true)], email: "f88@.com", company: "tam", dateOfBirth: "05/08/2022"),
        Person(id: "12", images: "", name: "luan", phoneNumber: [PhoneRow(phoneNumber: "1212", phoneType: "school", displayStatus: true)], email: "luan@999.com", company: "bang", dateOfBirth: "06/08/2022"),
        
    ]
    // var titles: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    var searchDS = [String: [Person]]()
    
    var sectionTitle = [String]()
    var tenDict = [String: [Person]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Liên hệ"
        searchBar.delegate = self
        myTable.delegate = self
        
        myTable.dataSource = self  // dòng này cấu hình cho myTable để cho 2 hàm cellForRowAt, numberRowInSection
        
        for person in DSTen {
            let prefixName = person.Name.prefix(1).lowercased()
            if (!tenDict.keys.contains(String(prefixName))) {
                tenDict[String(prefixName)] = []
            }
            tenDict[String(prefixName)]?.append(person)
        }
        searchDS = tenDict
        //xếp tên theo kí tự        //var sectionTitle = [String]()
        sectionTitle = searchDS.keys.sorted()
        sectionTitle.sort()
    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(true)
    //        print("zzzzz")
    //        func removeObserver(_: Any, name: NSNotification.Name? , Object: Any) {
    //
    //        }
    //        NotificationCenter.default.removeObserver(self)
    //     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("aaaaa")
        //cột nhận tín hiệu từ MH Sua12
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.classListUpdate2(_:)),
                                               name: Notification.Name("TestNotification"),
                                               object: nil)
        
        //cột nhận tín hiệu từ MH ThemMoi
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.classAddNew(_:)),
                                               name: Notification.Name("UseNoti"),
                                               object: nil);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        NotificationCenter.default.removeObserver(self,
//                                               name: Notification.Name("TestNotification"),
//                                               object: nil)
        NotificationCenter.default.removeObserver(self,
                                               name: Notification.Name("UseNoti"),
                                               object: nil);
    }
    //ham thuc thi viec sua tu MH12
    @objc func classListUpdate2(_ notification: Notification) -> Void {
        print("co vao11")
        let details:Person = (notification.userInfo!["details"] as? Person)!
        
        for person in DSTen {
            if person.ID == details.ID {
                person.Images = details.Images
                person.Name = details.Name
                person.PhoneNumber = details.PhoneNumber
                person.Email = details.Email
                person.DateOfBirth = details.DateOfBirth
                person.Company = details.Company
                //break
            }
        }
        
        tenDict = [String: [Person]]()
        searchDS = [String: [Person]]()
        for person in DSTen {
            let prefixName = person.Name.prefix(1).lowercased()
            if (!tenDict.keys.contains(String(prefixName))) {
                tenDict[String(prefixName)] = []
            }
            tenDict[String(prefixName)]?.append(person)
        }
        
        searchDS = tenDict
        //xếp tên theo kí tự        //var sectionTitle = [String]()
        sectionTitle = searchDS.keys.sorted()
        sectionTitle.sort()
        myTable.reloadData()
    }
    
    //ham them moi
    @objc func classAddNew(_ notification : Notification){
        print("bbb")
        let detailPerson:Person = (notification.userInfo!["details"] as? Person)!
        self.DSTen.append(detailPerson)
        tenDict = [String: [Person]]()
        searchDS = [String: [Person]]()
        
        for person in DSTen {
            let prefixName = person.Name.prefix(1).lowercased()
            if (!tenDict.keys.contains(String(prefixName))) {
                tenDict[String(prefixName)] = []
            }
            tenDict[String(prefixName)]?.append(person)
        }
        
        searchDS = tenDict
        //xếp tên theo kí tự        //var sectionTitle = [String]()
        sectionTitle = searchDS.keys.sorted()
        sectionTitle.sort()
        self.myTable.reloadData()
    }
    
    //chuyển đến classListUpdate2
    //    @objc private func willEnterForeground(_ notification: Notification) {
    //        let details = notification.userInfo?["details"] as? Person
    //        if details != nil {
    //            //print(details?.Name)
    //            self.classListUpdate2(with: details!)
    //        }
    //    }
    
    
    //chuyển đến classAddNew
    //    @objc private func willEnter(_ notification : Notification) {
    //        let details:Person = (notification.userInfo!["details"] as? Person)!
    //
    //        //if details != nil {
    //        self.classAddNew(with: details)
    //        //}
    //
    //
    //    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //
    //        NotificationCenter.default.addObserver(self,
    //                                      selector: #selector(self.willEnterForeground(_:)),
    //                                      name: Notification.Name("UseNoti"),
    //                                      object: nil)
    //        print("da nhan dc tin hieu truyen")
    //    }
    //    @objc private func willEnterForeground(_ notification: Notification) {
    //        let details = notification.userInfo?["details"] as? Person
    //        if details != nil {
    //            print("")
    //            self.classListUpdate(with: details!)
    //        }
    //    }
    
    // hiện thị số hàng trong trong section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDS[sectionTitle[section]]?.count ?? 0
        //return searchDS.count
    }
    
    //nhóm tên theo a,b,c...hiển thị dl ra tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "CELL") as! DongMH1Cell
        let items = searchDS[sectionTitle[indexPath.section]] ?? []
        if !items.isEmpty {
            let item = items[indexPath.row]
            cell.lblName.text = item.Name
            
            //cell.lblPhoneNumber.text = item.PhoneNumber
            
            //        cell.lblName.text = DSTen[indexPath.row].Name
            //        cell.lblPhoneNumber.text = DSTen[indexPath.row].PhoneNumber
        }
        return cell
    }
    
    //nhom ra bảng chữ bên phải MH
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        //yêu cầu nguồn dữ liệu trả về tiêu để(title) cho các section trong chế độ tableView
        return sectionTitle
    }
    //  hiển thị ra = số lượng chữ cái trong bảng đếm được
    func numberOfSections(in tableView: UITableView) -> Int { //khai báo số lượng section
        //yêu cầu nguồn dữ liệu trả về số lượng section trong chế độ tableView
        return  sectionTitle.count
    }
    
    //tao ra cac Section Header là a, b ,c ,...
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    //dùng segue truyền data giữa các ViewController (truyền xuôi từ MH1 -> Mh Detail )
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MH1DetailVC,
           let cell = sender as? UITableViewCell,
           let indexPath = myTable.indexPath(for: cell) {
            let items = searchDS[sectionTitle[indexPath.section]] ?? []
            let item: Person = items[indexPath.row]
            vc.item = item
            
            //vc.listDelegrate = self
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click vao cell")
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "MH1DetailVC" ) as! MH1DetailVC
        let items1 = searchDS[sectionTitle[indexPath.section]] ?? []
        detail.item = items1[indexPath.row]
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //xóa dữ liệu trong tableView
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let persons = searchDS[sectionTitle[indexPath.section]] ?? []
            let person: Person = persons[indexPath.row]
            
            DSTen.removeAll(where: {$0.ID == person.ID})
            tenDict.removeAll()
            
            for person in DSTen {
                let prefixName = person.Name.prefix(1).lowercased()
                if (!tenDict.keys.contains(String(prefixName))) {
                    tenDict[String(prefixName)] = []
                }
                
                tenDict[String(prefixName)]?.append(person)
                
            }
            searchDS = tenDict

            myTable.reloadData()
        }
    }
}

//chứa năng tìm kiếm
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {  //khi searchBar trống thì searchDS được gán = tenDict
            searchDS  = tenDict
        } else {
            searchDS.removeAll() // xoa hết các phần tử trong dict
            for (keyD, valueD) in tenDict {
                if !searchDS.keys.contains(keyD) { // nếu không tồn tại key trong kiểu Dict
                    //contains: kiểm tra một đối tượng có tồn tại trong một collection - array , set , (dictionary)
                    searchDS[keyD] = [Person]()    // thì gán key trong SearchDS là một mảng Person
                }
                for person in valueD {
                    if (person.Name.lowercased().contains(searchText.lowercased())) /*|| (person.PhoneNumber.contains(searchText)) */{
                        searchDS[keyD]?.append(person)
                    }
                    //                    if tenDict.contains(searchText.lowercased()) {  //không phân biệt chữ hoa hay thường trong SearchBar
                    //                        searchDS[keyD]?.append(person)
                    //                    }
                }
            }
            searchDS = searchDS.filter({!$0.value.isEmpty}) //lọc các pt value trong searchDS khi giá trị trong Kiểu Dict bị trống
            //$0: là đối số đầu tiên  của value trong Dict
        }
        sectionTitle = Array(Set(searchDS.compactMap({String($0.key.prefix(1)) } ))) //loại bỏ các phần tử các key- a,b, c...khi bị lặp lại trong mảng key của searchDS
        sectionTitle.sort() // sap xep các chỉ mục theo thứ tự a->z
        myTable.reloadData()
    }
}

//extension ViewController: UpdateContactAfterProtocol {
//    func classListUpdate(with detailPerson: Person) {
//        
//        tenDict[String(detailPerson.Name.prefix(1).lowercased())]?.append(detailPerson)
//        searchDS = tenDict
//
//        print(tenDict)
//        //xếp tên theo kí tự        //var sectionTitle = [String]()
//        sectionTitle = searchDS.keys.sorted()
//        sectionTitle.sort()
//                
//        self.myTable.reloadData()
//    }
//}


//extension ViewController: SenderViewControllerDelagate {
//    func passpersonDetails(data: AnyObject) {
//        self.DSTen.append(detailPerson)
//
//        tenDict = [String: [Person]]()
//        searchDS = [String: [Person]]()
//
//        for person in DSTen {
//            let _prefixName = person.Name.prefix(1).lowercased()
//            if (!tenDict.keys.contains(String(_prefixName))) {
//                tenDict[String(_prefixName)] = []
//            }
//            tenDict[String(_prefixName)]?.append(person)
//        }
//
//        searchDS = tenDict
//        //xếp tên theo kí tự        //var sectionTitle = [String]()
//        sectionTitle = searchDS.keys.sorted()
//        sectionTitle.sort()
//        self.myTable.reloadData()
//    }
    

//    func classAddNew(with detailPerson: Person){
//        self.DSTen.append(detailPerson)
//
//        tenDict = [String: [Person]]()
//        searchDS = [String: [Person]]()
//
//        for person in DSTen {
//            let _prefixName = person.Name.prefix(1).lowercased()
//            if (!tenDict.keys.contains(String(_prefixName))) {
//                tenDict[String(_prefixName)] = []
//            }
//            tenDict[String(_prefixName)]?.append(person)
//        }
//
//        searchDS = tenDict
//        //xếp tên theo kí tự        //var sectionTitle = [String]()
//        sectionTitle = searchDS.keys.sorted()
//        sectionTitle.sort()
//        self.myTable.reloadData()
//    }




//    func classListUpdate(with detailPerson: Person) {
//        self.DSTen.append(detailPerson)
//
//        tenDict = [String: [Person]]()
//        searchDS = [String: [Person]]()
//
//        for person in DSTen {
//            let _prefixName = person.Name.prefix(1).lowercased()
//            if (!tenDict.keys.contains(String(_prefixName))) {
//                tenDict[String(_prefixName)] = []
//            }
//            tenDict[String(_prefixName)]?.append(person)
//        }
//
//        searchDS = tenDict
//        //xếp tên theo kí tự        //var sectionTitle = [String]()
//        sectionTitle = searchDS.keys.sorted()
//        sectionTitle.sort()
//        self.myTable.reloadData()
//    }

//    func classListUpdate2(with newPerson: Person) -> Bool {
//        //print("hienchitiet")
//            for person in DSTen {
//            if person.ID == newPerson.ID {
//                person.Images = newPerson.Images
//                person.Name = newPerson.Name
//                person.PhoneNumber = newPerson.PhoneNumber
//                person.Email = newPerson.Email
//                person.DateOfBirth = newPerson.DateOfBirth
//                person.Company = newPerson.Company
//            }
//        }
//
//        tenDict = [String: [Person]]()
//        searchDS = [String: [Person]]()
//
//        for person in DSTen {
//            let _prefixName = person.Name.prefix(1).lowercased()
//            if (!tenDict.keys.contains(String(_prefixName))) {
//                tenDict[String(_prefixName)] = []
//            }
//            tenDict[String(_prefixName)]?.append(person)
//        }
//
//        searchDS = tenDict
//        //xếp tên theo kí tự        //var sectionTitle = [String]()
//        sectionTitle = searchDS.keys.sorted()
//        sectionTitle.sort()
//        self.myTable.reloadData()
//
//        return true
//    }

//}





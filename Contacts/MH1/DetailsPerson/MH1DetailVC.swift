//
//  MH1DetailVC.swift
//  Contacts
//
//  Created by Vuong The Vu on 05/08/2022.
//

import UIKit

//protocol Update2ContactAfterProtocol: class {
//    func classListUpdate2( with detailPerson: Person)
//}

//typealias person = (Person) -> ()
class MH1DetailVC: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    //    var clousure: person!
    var selectedImage: UIImage!
    var item: Person!
    var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    
    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var imgImage: UIImageView!
    
    
    @IBAction func btnEdit(_ sender: Any) {
        print("click vao btnEdit")
        guard let mhSua =  self.storyboard?.instantiateViewController(identifier:  "SuaVC12") as? SuaVC12 else {return}
        mhSua.personDetailsOriginal = item!
        navigationController?.pushViewController(mhSua, animated: true)
        
        //                guard let person = item else {return}
        //        clousure(person)
    }
    
    // weak var listDelegrate: UpdateContactAfterProtocol? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return item.PhoneNumber.filter({$0.DisplayStatus == true}).count
        }else if (section == 2) {
            return 1
        }else if (section == 3) {
            return 1
        }else if (section == 4) {
            return 1
        }else if (section == 5) {
            return 1
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellName") as! CellDetail
            cell.lblName.text = item?.Name
            return cell
            
        } else if (indexPath.section == 1) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneType") as! CellDetail
            let visibleRecords = item.PhoneNumber.filter({$0.DisplayStatus == true})
            let item1 = visibleRecords[indexPath.row]
            cell.lblPhoneType.text = item1.PhoneType
            cell.lblPhoneNumber.text = item1.PhoneNumber
            
            return cell
            
        } else if (indexPath.section == 2) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellEmail") as! CellDetail
            cell.lblEmail.text = item?.Email
            return cell
            
        } else if (indexPath.section == 3){
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellCompany") as! CellDetail
            cell.lblCompany.text = item?.Company
            return cell
        } else if(indexPath.section == 4) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellDOfB") as! CellDetail
            cell.lblDOB.text = item?.DateOfBirth
            return cell
        } else if (indexPath.section == 5) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellDetail
            cell.lblID.text = item?.ID
            return cell
        } else {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellDetail
            return cell
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        
        imgImage.image = UIImage(named: item.Images )
        
        imgImage.layer.cornerRadius = imgImage.frame.width / 2
        imgImage.clipsToBounds = true
        selectedImage = self.load(fileName: item!.Images)
        imgImage.image = selectedImage
        
        
    }
    
    //MH1 DetailVC nhan dc notifcation tu MHSua12
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.classListUpdate1(_:)),
                                               name: Notification.Name("TestNotification"),
                                               object: nil
        )
    }
    
    
    //    @objc private func willEnterForeground(_ notification: Notification) {
    //        let details = notification.userInfo?["details"] as? Person
    //        if details != nil {
    //            //print(details?.Name)
    //            self.classListUpdate2(with: details!)
    //        }
    //        print("MH1 DetailVC nhan dc notification tu MHSua12")
    //        
    //    }
    //ham lam viec
    @objc func classListUpdate1(_ notification: Notification)  {
        let details = notification.userInfo?["details"] as? Person
        item = details
        
        
        if let imageView = self.load(fileName: details?.Images ?? "") {
            imgImage.image = imageView as UIImage
        }
        myTable.reloadData()
        
        //        let cellName =  myTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! CellDetail
        //        cellName.lblName.text = details.Name
        //
        //        let cellPhoneType = myTable.cellForRow(at: IndexPath(row: 1, section: 1)) as! CellDetail
        ////        cellPhoneType.lblPhoneNumber.text = details.PhoneNumber.[cellPhoneType]
        //
        //        let cellEmail =  myTable.cellForRow(at: IndexPath(row: 0, section: 2)) as! CellDetail
        //        cellEmail.lblEmail.text = details.Email
        //
        //        let cellCompany =  myTable.cellForRow(at: IndexPath(row: 0, section: 3)) as! CellDetail
        //        cellCompany.lblCompany.text = details.Company
        //
        //        let celldob =  myTable.cellForRow(at: IndexPath(row: 0, section: 4)) as! CellDetail
        //        celldob.lblDOB.text = details.DateOfBirth
        
    }
    
    
    
    private func save(image: UIImage!) -> String? {
        if (image != nil) {
            let fileName = "FileName"
            let fileURL = documentsURL.appendingPathComponent(fileName)
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                try? imageData.write(to: fileURL, options: .atomic)
                print("luu anh ok\(fileName)")
                return fileName // ----> Save fileName
            }
        }
        print("Luu anh loi")
        return ""
    }
    
    private func load(fileName: String) -> UIImage? {
        if !fileName.isEmpty {
            let fileURL = documentsURL.appendingPathComponent(fileName)
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
            }
        }
        return nil
    }
    
    //dùng segue truyền xuoi data giữa các ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("pass data Detail -> Sua", item.Name)
        if let nav = segue.destination as? UINavigationController,
           let edit = nav.viewControllers.first as? SuaVC12 {
            edit.personDetailsOriginal = item
            
            
            // edit.listDelegrate = listDelegrate
            //edit.detailDelegrate = self
        }
    }
    
    
    //extension MH1DetailVC: Update2ContactAfterProtocol {
    
    //    func classListUpdate2(with detailPerson: Person) {
    //        print("vao hien thi chi tiet MH1Detail")
    //
    //        imgImage.image = UIImage(named: detailPerson.Images)
    //        imgImage.reloadInputViews()
    //
    //        lblName.text = detailPerson.Name
    //        lblName.reloadInputViews()
    //
    //        lblPhoneNumber.text = detailPerson.PhoneNumber
    //        lblPhoneNumber.reloadInputViews()
    //
    //        lblEmail.text = detailPerson.PhoneNumber
    //        lblPhoneNumber.reloadInputViews()
    //
    //        lblEmail.text = detailPerson.Email
    //        lblEmail.reloadInputViews()
    //
    //        lblCompany.text = detailPerson.Company
    //        lblCompany.reloadInputViews()
    //
    //        lblDateOfBirth.text = detailPerson.DateOfBirth
    //        lblDateOfBirth.reloadInputViews()
    //
    //    }
    //}
    
}

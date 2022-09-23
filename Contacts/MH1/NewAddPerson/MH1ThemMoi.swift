//
//  MH1ThemMoi.swift
//  Contacts
//
//  Created by Vuong The Vu on 18/08/2022.
//

import UIKit
import RealmSwift

class MH1ThemMoi: UIViewController , UITableViewDataSource {
    @IBOutlet weak var selectedImageImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var myTable: UITableView!
    
    var personDetails: Person = Person()
    
    var selectedImage: UIImage!
    
    var phoneTypes:[String] = ["mobile", "company", "home", "school", "main", "work"]
    
    var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    //    var phone: [PhoneRow] = [
    //                PhoneRow(phoneNumber: "", phoneType: "mobile", displayStatus: true),
    //                PhoneRow(phoneNumber: "", phoneType: "home", displayStatus: false),
    //                PhoneRow(phoneNumber: "", phoneType: "company", displayStatus: false),
    //                PhoneRow(phoneNumber: "", phoneType: "school", displayStatus: false),
    //                PhoneRow(phoneNumber: "", phoneType: "main", displayStatus: false),
    //                PhoneRow(phoneNumber: "", phoneType: "company fax", displayStatus: false)
    //            ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageImageView.layer.cornerRadius = selectedImageImageView.frame.size.width / 2
        //bo tron khi hinh rong hon
        selectedImageImageView.clipsToBounds = true
        myTable.dataSource = self
        
    }
    
    
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        
        if (myTable.cellForRow(at: IndexPath(row: 0, section: 0)) != nil) {
            let cell = myTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! CellName
            //        let cell1 = myTable.cellForRow(at: IndexPath(row: 1, section: 1)) as? CellPhoneType
            //        let cell2 = myTable.cellForRow(at: IndexPath(row: 0, section: 2)) as? CellEmail
            //        let cell3 = myTable.cellForRow(at: IndexPath(row: 0, section: 3)) as? CellCompany
            //        let cell4 = myTable.cellForRow(at: IndexPath(row: 0, section: 4)) as? CellDofB
            //                if let cell5 = myTable.cellForRow(at: IndexPath(row: 0, section: 5)) as? CellId
            //                { }
            
            
            if (cell.txtName.text != "") {
                //personDetails.id =
                personDetails.image = self.save(image: selectedImage) ?? ""
                
                let person = Person()
                //person.id = personDetails.id
                person.image = personDetails.image
                person.name = personDetails.name
                person.email = personDetails.email
                person.company = personDetails.company
                person.dob = personDetails.dob
                person.phone = personDetails.phone
                DBManager.shareInstance.addData(object: person)
                
                //print("nhay vao xong MH Them moi")
                //            print("", personDetails.PhoneNumber[1].DisplayStatus)
                //            let personDetails = Person(id: randomString(length: 6), images: selectedImageName, name: cell.txtName.text ?? "", phoneNumber: personDetails.PhoneNumber , email: cell2?.txtEmail.text ?? "", company: cell3?.txtCompany.text ?? "", dateOfBirth: cell4?.txtDOB.text ?? "")
                myTable.reloadData()
                self.dismiss(animated: true)
                
                print("them moi phat Th")
                //phat tin hieu de them moi
                NotificationCenter.default.post(name: Notification.Name("UseNoti"), object: nil , userInfo: ["details" : personDetails])
            }
        }
    }
    
    @IBAction func selectImageButtonAction(_ sender: UIButton) {
        print("ấn  thêm ảnh ở MHThemMoi")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnAddRow(_ sender: Any) {
        print("click btn Add")
        // Lay tat ca cac cell trong section 1
        var newPhoneType = phoneTypes[0]
        //Lay so luong row trong section 1
        let countRows = myTable.numberOfRows(inSection: 1)
        var arrTemp = phoneTypes
        for i in 1..<countRows {
            if (myTable.cellForRow(at: IndexPath(row: i, section: 1)) != nil) {
                let cellAtIdex1 = myTable.cellForRow(at: IndexPath(row: i, section: 1)) as! CellPhoneType
                let phoneType = cellAtIdex1.lblPhoneType.text ?? ""
                arrTemp = arrTemp.filter({!$0.hasPrefix(phoneType)})
            }
        }
        if !arrTemp.isEmpty {
            newPhoneType = arrTemp[0]
        }
        // Duyet cac row trong section, de lay cell
        // Tu cell se lay duoc phoneType
        // Filter phoneTypes de loai bo nhung thang da co
        // myTable.cellForRow(at: )
        // Them moi thang chua co
        let phoneRow = PhoneRow.init()
        phoneRow.phoneNumber = ""
        phoneRow.phoneType = newPhoneType
        // phoneRow.phoneNumber = ""
        // phoneRow.phoneType = "home"
        personDetails.phone.append(phoneRow)
        myTable.reloadData()
        
        //        let hiddenRecords = personDetails
        //
        //        personDetails.phone.append(phoneRow)
        //
        //        if !hiddenRecords.isEmpty {
        //            let recordToBeInsert: PhoneRow = hiddenRecords.first!
        //            recordToBeInsert.displayStatus = true
        //            myTable.reloadData()
        //        }
    }
    
    @IBAction func btnDeleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myTable)
        guard let indexPath = myTable.indexPathForRow(at: point) else {return}
//        let cell = myTable.cellForRow(at: indexPath) as! CellPhoneTypeModify
        //let phoneType = cell.lblPhoneType.text!

        personDetails.phone.remove(at: indexPath.row-1)
        myTable.reloadData()
    }
    private func save(image: UIImage!) -> String? {
        if (image != nil) {
            let fileName:String = image.imageAsset?.value(forKey: "assetName") as! String
            let fileURL = documentsURL.appendingPathComponent(fileName)
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                try? imageData.write(to: fileURL, options: .atomic)
                //print("ham lu anh \(fileName)")
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
    
    
    //    func randomString(length: Int) -> String {
    //        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    //        return String((0..<length).map{ _ in letters.randomElement()! })
    //    }
    
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        print("a the a ")
    //        //func removeObserver( name: Notification.Name("UseNoti") , Object: Any) {
    //            NotificationCenter.default.removeObserver(self)
    //        //}
    //    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else if (section == 1) {
            return personDetails.phone.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellName") as! CellName
            cell.txtName.addTarget(self, action: #selector(self.onInputNameChange(_:)), for: .editingChanged)
            
            //cell.txtName.text = personDetails.Name
            return cell
            
        } else if (indexPath.section == 1) {
            if(indexPath.row == 0) {
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneAdd") as! CellPhoneAdd
                
                cell.btnAdd.addTarget(self, action: #selector(self.onInputChange(_:)), for: .allEditingEvents)
                return cell
            } else {
                print("Hello..\(indexPath.row)")
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneType") as! CellPhoneType
                
                let visibleRecords = personDetails.phone
                let item1 = visibleRecords[indexPath.row - 1]
                cell.lblPhoneType.text = item1.phoneType
                cell.txtPhoneNumber.text = item1.phoneNumber
                
                
                cell.txtPhoneNumber.addTarget(self, action: #selector(self.onInputChange(_:)), for: .editingChanged)
                cell.txtPhoneNumber.tag = indexPath.row - 1
                
                return cell
            }
        } else if (indexPath.section == 2) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellEmail") as! CellEmail
            cell.txtEmail.addTarget(self, action: #selector(self.onInputEmailChange(_:)), for: .editingChanged)
            //  cell.txtEmail.text = personDetails.Email
            return cell
        } else if (indexPath.section == 3) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellCompany") as! CellCompany
            cell.txtCompany.addTarget(self, action: #selector(self.onInputCompanyChange(_:)), for: .editingChanged)
            // cell.txtCompany.text = personDetails.Company
            return cell
        } else if (indexPath.section == 4) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellDOfB") as! CellDofB
            cell.txtDOB.addTarget(self, action: #selector(self.onInputDOBChange(_:)), for: .editingChanged)
            //cell.txtDOB.text = personDetails.DateOfBirth
            return cell
        } else if (indexPath.section == 5) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellId
            
            // cell.txtID.text = personDetails.ID
            //print("id", personDetails.ID)
            
            return cell
        } else {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId")
            return cell!
        }
    }
    
    @objc func onInputNameChange(_ sender: UITextField) {
        print("name", sender.text ?? "")
        personDetails.name = sender.text ?? ""
        
    }
    @objc func onInputChange(_ sender: UITextField)
    {
        let tag = sender.tag
        // tag => Type
        // sender?.text => PhoneNumber
        // personDetails.phoneNumber = ..
        print("\(personDetails.phone.count)")
        if (personDetails.phone.count > tag) {
            print("MH ThemSDT", tag)
            let phone = personDetails.phone[tag]
            if phone != nil  {
                phone.phoneNumber = sender.text ?? ""
            }
        }
    }
    
    @objc func onInputEmailChange(_ sender: UITextField) {
        personDetails.email = sender.text ?? ""
    }
    
    @objc func onInputCompanyChange(_ sender: UITextField) {
        personDetails.company = sender.text ?? ""
    }
    @objc func onInputDOBChange(_ sender: UITextField) {
        personDetails.dob = sender.text ?? ""
    }
}

extension MH1ThemMoi: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard info[.imageURL] is URL else {
            return
        }
        
        if let pickedImage = info[.originalImage] as? UIImage {
            selectedImage = pickedImage
            selectedImageImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}



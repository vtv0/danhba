//
//  MH1ThemMoi.swift
//  Contacts
//
//  Created by Vuong The Vu on 18/08/2022.
//

import UIKit
//import Contacts

class MH1ThemMoi: UIViewController , UITableViewDataSource {
    @IBOutlet weak var selectedImageImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var myTable: UITableView!
    
    var personDetails: Person = Person(id: "", images: "", name: "", email: "", company: "", dateOfBirth: "")
    
    var selectedImage: UIImage!
    
    var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        
        let cell = myTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! CellName
        //let cell1 = myTable.cellForRow(at: IndexPath(row: 1, section: 1)) as? CellPhoneType
        //let cell2 = myTable.cellForRow(at: IndexPath(row: 0, section: 2)) as? CellEmail
        //let cell3 = myTable.cellForRow(at: IndexPath(row: 0, section: 3)) as? CellCompany
        //let cell4 = myTable.cellForRow(at: IndexPath(row: 0, section: 4)) as? CellDofB
        //        if let cell5 = myTable.cellForRow(at: IndexPath(row: 0, section: 5)) as? CellId
        //        { }
        
        let numOfRows: Int = myTable.numberOfRows(inSection: 1)
        for i in 1..<numOfRows {
            let cellAtIdx = myTable.cellForRow(at: IndexPath(row: i, section: 1)) as! CellPhoneType
            
            let phoneType = cellAtIdx.lblPhoneType.text
            let phoneNumber = cellAtIdx.txtPhoneNumber.text
            
            let personDetails = personDetails.PhoneNumber.filter({$0.PhoneType == phoneType}).first!
            personDetails.PhoneNumber = phoneNumber!
            personDetails.DisplayStatus = true
        }
        
        if (cell.txtName.text != "") {
            //print("nhay vao xong MH Them moi")
            
            personDetails.Images = self.save(image: selectedImage) ?? ""
            
            //            print("", personDetails.PhoneNumber[1].DisplayStatus)
            //            let personDetails = Person(id: randomString(length: 6), images: selectedImageName, name: cell.txtName.text ?? "", phoneNumber: personDetails.PhoneNumber , email: cell2?.txtEmail.text ?? "", company: cell3?.txtCompany.text ?? "", dateOfBirth: cell4?.txtDOB.text ?? "")
            
            personDetails.ID = randomString(length: 6)
            self.dismiss(animated: true)
            
            //phat tin hieu de them moi
            NotificationCenter.default.post(name: Notification.Name("UseNoti"), object: nil , userInfo: ["details" : personDetails])
            //print("111a: \(personDetails)")
            //print(personDetails)
        }
    }
    
    //    @IBAction func onNameChange(_ sender: UITextField) {
    //        print("", sender.text as Any)
    //        //let name = personDetails.Name
    //        //personDetails.Name = sender.text!
    //    }
    //
    //    @IBAction func onEmailChange(_ sender: UITextField) {
    //        print("a", sender.text as Any)
    //        //let email = personDetails.Email
    //        //personDetails.Email = sender.text!
    //    }
    //
    //    @IBAction func onCompany(_ sender: UITextField) {
    //        print("b", sender.text  as Any)
    //        //personDetails.Company = sender.text!
    //        //let company = personDetails.Company
    //    }
    //
    //    @IBAction func onDOB(_ sender: UITextField) {
    //        print("c", sender.text as Any)
    //        //let dob = personDetails.DateOfBirth
    //        //personDetails.DateOfBirth = sender.text!
    //    }
    
    
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
        let hiddenRecords = personDetails.PhoneNumber.filter({$0.DisplayStatus == false})
        if !hiddenRecords.isEmpty {
            let recordToBeInsert: PhoneRow = hiddenRecords.first!
            recordToBeInsert.DisplayStatus = true
            //                        myTable.performBatchUpdates({
            //                            myTable.insertRows(at: [IndexPath(row: 1, section: 1)], with: .left)
            //                        })
            
            myTable.reloadData()
        }
    }
    
    @IBAction func btnDeleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myTable)
        guard let indexPath = myTable.indexPathForRow(at: point) else {return}
        let cell = myTable.cellForRow(at: indexPath) as! CellPhoneType
        let phoneType = cell.lblPhoneType.text!
        
        let selectedPhoneType: PhoneRow = personDetails.PhoneNumber.filter({$0.PhoneType == phoneType}).first!
        //if selectedPhoneType != nil {
        selectedPhoneType.DisplayStatus = false
        
        //}
        myTable.reloadData()
    }
    
    private func save(image: UIImage!) -> String? {
        if (image != nil) {
            let fileName = "FileName"
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
    
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageImageView.layer.cornerRadius = selectedImageImageView.frame.size.width / 2
        //bo tron khi hinh rong hon
        selectedImageImageView.clipsToBounds = true
        myTable.dataSource = self
    }
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
            return personDetails.PhoneNumber.filter({$0.DisplayStatus == true}).count + 1
            
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
                
                //cell.btnAdd.addTarget(self, action: #selector(self.onInputChange(_:)), for: .allEditingEvents)
                return cell
            } else {
                //print("Hello")
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneType") as! CellPhoneType
                
                let visibleRecords = personDetails.PhoneNumber.filter({$0.DisplayStatus == true})
                let item1 = visibleRecords[indexPath.row - 1]
                cell.lblPhoneType.text = item1.PhoneType
                cell.txtPhoneNumber.text = item1.PhoneNumber
                
                
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
        print("name", sender.text ?? "hon")
        personDetails.Name = sender.text ?? ""
        
    }
    @objc func onInputChange(_ sender: UITextField) {
        let tag = sender.tag
        // tag => Type
        // sender?.text => PhoneNumber
        // personDetails.phoneNumber = ..
        
        print("MH ThemSDT", tag)
        switch tag {
        case 0:
            //print("0",sender.text)
            personDetails.PhoneNumber[0].PhoneNumber = sender.text ?? ""
            
        case 1:
            //print("1",sender.text)
            
            personDetails.PhoneNumber[1].PhoneNumber = sender.text ?? ""
            
            
        case 2:
            //print("2", sender.text)
            personDetails.PhoneNumber[2].PhoneNumber = sender.text ?? ""
            
        case 3:
            //print("3", sender.text)
            personDetails.PhoneNumber[3].PhoneNumber = sender.text ?? ""
            
        case 4:
            //print("4", sender.text)
            personDetails.PhoneNumber[4].PhoneNumber = sender.text ?? ""
            
        case 5:
            //print("5", sender.text)
            personDetails.PhoneNumber[5].PhoneNumber = sender.text ?? ""
            
            
        default:
            print("69", sender.text!)
        }
    }
    
    @objc func onInputEmailChange(_ sender: UITextField) {
        personDetails.Email = sender.text ?? ""
    }
    
    @objc func onInputCompanyChange(_ sender: UITextField) {
        personDetails.Company = sender.text ?? ""
    }
    @objc func onInputDOBChange(_ sender: UITextField) {
        personDetails.DateOfBirth = sender.text ?? ""
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



//
//  SuaVC12.swift
//  Contacts
//
//  Created by Vuong The Vu on 16/08/2022.
//

import UIKit
class SuaVC12: UIViewController , UITableViewDataSource, UITableViewDelegate {
    var imagePicker = UIImagePickerController()
    var personDetailsOriginal: Person!
    var personDetails: Person!
    var selectedImage: UIImage!
    
    var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    @IBAction func btnHuy(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var btnSuaAnh: UIButton!
    @IBAction func btnSuaAnh(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // weak var listDelegrate: UpdateContactAfterProtocol? = nil
    // weak var detailDelegate: Update2ContactAfterProtocol? = nil
    
    @IBAction func btnXong(_ sender: Any) {
        if (!personDetails.Name.isEmpty) {
            personDetails.Images = self.save(image: selectedImage) ?? ""
            
            //self.dismiss(animated: true)
            //chuyen man hinh
            navigationController?.popViewController(animated: true)
            
            //  phat tin hieu de sua
            let dataToPass:[String: Person] = ["details": personDetails]
            let nc = NotificationCenter.default;
            nc.post(name: Notification.Name("TestNotification"), object: nil , userInfo: dataToPass)
            personDetailsOriginal = personDetails
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return  1
            
        } else if (section == 1) {
            return personDetails.PhoneNumber.filter({$0.DisplayStatus == true}).count + 1
            
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellName") as! CellModify
            cell.txtName.addTarget(self, action: #selector(self.onInputNameChange(_:)), for: .editingChanged)
            
            cell.txtName.text = personDetails.Name
            return cell
            
        } else if (indexPath.section == 1) {
            if(indexPath.row == 0) {
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneAdd") as! CellPhoneTypeModify
                
                //cell.btnAdd.addTarget(self, action: #selector(self.onInputChange(_:)), for: .allEditingEvents)
                return cell
            } else {
                //print("Hello")
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneType") as! CellPhoneTypeModify
                
                let visibleRecords = personDetails.PhoneNumber.filter({$0.DisplayStatus == true})
                let item1 = visibleRecords[indexPath.row - 1]
                cell.lblPhoneType.text = item1.PhoneType
                cell.txtPhoneNumber.text = item1.PhoneNumber
                
                
                cell.txtPhoneNumber.addTarget(self, action: #selector(self.onInputChange(_:)), for: .editingChanged)
                cell.txtPhoneNumber.tag = indexPath.row - 1
                
                return cell
            }
        } else if (indexPath.section == 2) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellEmail") as! CellModify
            cell.txtEmail.addTarget(self, action: #selector(self.onInputEmailChange(_:)), for: .editingChanged)
            cell.txtEmail.text = personDetails.Email
            return cell
        } else if (indexPath.section == 3) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellCompany") as! CellModify
            cell.txtCompany.addTarget(self, action: #selector(self.onInputCompanyChange(_:)), for: .editingChanged)
            cell.txtCompany.text = personDetails.Company
            return cell
        } else if (indexPath.section == 4) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellDOfB") as! CellModify
            cell.txtDOB.addTarget(self, action: #selector(self.onInputDOBChange(_:)), for: .editingChanged)
            cell.txtDOB.text = personDetails.DateOfBirth
            return cell
        } else if (indexPath.section == 5) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellModify
            
            cell.txtID.text = personDetails.ID
            //print("id", personDetails.ID)
            
            return cell
        } else {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId")
            
            return cell!
        }
    }
    
    @objc func onInputNameChange(_ sender: UITextField) {
        personDetails.Name = sender.text ?? ""
        // print("name", sender.text)
        //        personDetails.Name = sender.text ?? ""
        //        print("name" , sender.text)
    }
    @objc func onInputChange(_ sender: UITextField) {
        
        
        //myTable.numberOfRows(inSection: 1)
        let tag = sender.tag
        // tag => Type
        // sender?.text => PhoneNumber
        // personDetails.phoneNumber = ..
        
        print("MH Sua SDT", tag)
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
            // print("4", sender.text)
            personDetails.PhoneNumber[4].PhoneNumber = sender.text ?? ""
            
        case 5:
            //print("5", sender.text)
            personDetails.PhoneNumber[5].PhoneNumber = sender.text ?? ""
            
            
        default:
            print("69", sender.text ?? "")
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
    
    
    @IBAction func AddRow(_ sender: Any) {
        let hiddenRecords = personDetails.PhoneNumber.filter({$0.DisplayStatus == false})
        if !hiddenRecords.isEmpty {
            let recordToBeInsert:PhoneRow = hiddenRecords.first!
            recordToBeInsert.DisplayStatus = true
            //            myTable.performBatchUpdates({
            //                myTable.insertRows(at: [IndexPath(row: 0, section: 1)], with: .left)
            // })
            myTable.reloadData()
        }
    }
    
    @IBAction func btnDeleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myTable)
        guard let indexPath = myTable.indexPathForRow(at: point) else {return}
        let cell = myTable.cellForRow(at: indexPath) as! CellPhoneTypeModify
        let phoneType = cell.lblPhoneType.text!
        let selectedPhoneType: PhoneRow = personDetails.PhoneNumber.filter({$0.PhoneType == phoneType}).first!
        //if selectedPhoneType != nil {
        selectedPhoneType.DisplayStatus = false
        //}
        myTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chi tiết sửa"
        myTable.dataSource = self
        myTable.delegate = self
        
        personDetails = personDetailsOriginal.copy() as? Person
        //        phoneRow = phoneRowOriginal.copy() as! PhoneRow
        
        imgHinh.layer.cornerRadius = imgHinh.frame.width / 2
        imgHinh.clipsToBounds = true
        selectedImage = self.load(fileName: personDetails!.Images)
        imgHinh.image = selectedImage
    }
    
    private func save(image: UIImage!) -> String? {
        if (image != nil) {
            let fileName = "FileName"
            let fileURL = documentsURL.appendingPathComponent(fileName)
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                try? imageData.write(to: fileURL, options: .atomic)
                //print("aaa\(fileName)")
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
}

extension SuaVC12: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard info[.imageURL] is URL else {
            return
        }
        
        if let pickedImage = info[.originalImage] as? UIImage {
            selectedImage = pickedImage
            imgHinh.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}



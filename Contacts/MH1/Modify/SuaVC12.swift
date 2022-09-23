//
//  SuaVC12.swift
//  Contacts
//
//  Created by Vuong The Vu on 16/08/2022.
//

import UIKit
import RealmSwift

protocol DetachableObject: AnyObject {
  func detached() -> Self
}

extension Object: DetachableObject {
  func detached() -> Self {
    let detached = type(of: self).init()
    for property in objectSchema.properties {
        guard let value = value(forKey: property.name) else {
        continue
      }
      if let detachable = value as? DetachableObject {
        detached.setValue(detachable.detached(), forKey: property.name)
      } else { // Then it is a primitive
        detached.setValue(value, forKey: property.name)
      }
    }
    return detached
  }
}

//extension List: DetachableObject {
//  func detached() -> List<Element> {
//    let result = List<Element>()
//    forEach {
//      if let detachableObject = $0 as? DetachableObject,
//        let element = detachableObject.detached() as? Element {
//        result.append(element)
//      } else { // Then it is a primitive
//        result.append($0)
//      }
//    }
//    return result
//  }
//}

class SuaVC12: UIViewController , UITableViewDataSource, UITableViewDelegate {
    var imagePicker = UIImagePickerController()
    var personDetailsOriginal: Person!
    var personDetails: Person!
    var selectedImage: UIImage!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var imgHinh: UIImageView!
    @IBOutlet weak var btnSuaAnh: UIButton!
    
    var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chi tiết sửa"
        myTable.dataSource = self
        myTable.delegate = self

        // personDetails = personDetailsOriginal!
        //personDetails = Person(value: personDetailsOriginal!)
        
        personDetails = personDetailsOriginal.detached()
        //        phoneRow = phoneRowOriginal.copy() as! PhoneRow
        
        imgHinh.layer.cornerRadius = imgHinh.frame.width / 2
        imgHinh.clipsToBounds = true
        selectedImage = self.load(fileName: personDetails!.image)
        imgHinh.image = selectedImage
    }
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
    @IBAction func btnHuy(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnXong(_ sender: Any) {
        if (!personDetails.name.isEmpty) {
            personDetails.image = self.save(image: selectedImage) ?? ""
            
            let personEdit = Person()
            personEdit.id = personDetails.id
            personEdit.image = personDetails.image
            personEdit.name = personDetails.name
            personEdit.email = personDetails.email
            personEdit.company = personDetails.company
            personEdit.dob = personDetails.dob
            personEdit.phone = personDetails.phone
            DBManager.shareInstance.updateToDB(object: personEdit)
            self.dismiss(animated: true)
            //chuyen man hinh
            navigationController?.popViewController(animated: true)
            
            //  phat tin hieu de sua
            let dataToPass:[String: Person] = ["details": personDetails]
            let nc = NotificationCenter.default;
            nc.post(name: Notification.Name("TestNotification"), object: nil , userInfo: dataToPass)
//            personDetailsOriginal = personDetails
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return  1
            
        } else if (section == 1) {
            return personDetails.phone.count + 1  /*.filter({$0.DisplayStatus == true})*/
            
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellName") as! CellModify
            cell.txtName.addTarget(self, action: #selector(self.onInputNameChange(_:)), for: .editingChanged)
            
            cell.txtName.text = personDetails.name
            return cell
            
        } else if (indexPath.section == 1) {
            if(indexPath.row == 0) {
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneAdd") as! CellPhoneTypeModify
                
                cell.btnAdd.addTarget(self, action: #selector(self.onInputChange(_:)), for: .editingChanged)
                return cell
            } else {
                
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneType") as! CellPhoneTypeModify
                
                let visibleRecords = personDetails.phone/*.filter({$0.DisplayStatus == true})*/
                let item1 = visibleRecords[indexPath.row - 1]
                cell.lblPhoneType.text = item1.phoneType
                cell.txtPhoneNumber.text = item1.phoneNumber
                
                
                cell.txtPhoneNumber.addTarget(self, action: #selector(self.onInputChange(_:)), for: .editingChanged)
                cell.txtPhoneNumber.tag = indexPath.row - 1
                
                return cell
            }
        } else if (indexPath.section == 2) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellEmail") as! CellModify
            cell.txtEmail.addTarget(self, action: #selector(self.onInputEmailChange(_:)), for: .editingChanged)
            cell.txtEmail.text = personDetails.email
            return cell
        } else if (indexPath.section == 3) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellCompany") as! CellModify
            cell.txtCompany.addTarget(self, action: #selector(self.onInputCompanyChange(_:)), for: .editingChanged)
            cell.txtCompany.text = personDetails.company
            return cell
        } else if (indexPath.section == 4) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellDOfB") as! CellModify
            cell.txtDOB.addTarget(self, action: #selector(self.onInputDOBChange(_:)), for: .editingChanged)
            cell.txtDOB.text = personDetails.dob
            return cell
        } else if (indexPath.section == 5) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellModify
            
            //cell.txtID.text = personDetails.id
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
    @objc func onInputChange(_ sender: UITextField) {
        let tag = sender.tag
       
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
    
    
    @IBAction func AddRow(_ sender: Any) {
        let phoneTypes:[String] = ["mobile", "company", "home", "school", "main", "work"]
        var newPhoneType = phoneTypes[0]
        let countRows = myTable.numberOfRows(inSection: 1)
        var arrTemp = phoneTypes
        for i in 1..<countRows {
            if (myTable.cellForRow(at: IndexPath(row: i, section: 1)) != nil) {
                let cellAtIdex1 = myTable.cellForRow(at: IndexPath(row: i, section: 1)) as! CellPhoneTypeModify
                let phoneType = cellAtIdex1.lblPhoneType.text ?? ""
                arrTemp = arrTemp.filter({!$0.hasPrefix(phoneType)})
            }
        }
        if !arrTemp.isEmpty {
            newPhoneType = arrTemp[0]
        }
        let phoneRow = PhoneRow.init()
        phoneRow.phoneNumber = ""
        phoneRow.phoneType = newPhoneType
        personDetails.phone.append(phoneRow)
        myTable.reloadData()
    }
    
    @IBAction func btnDeleteRow(_ sender: UIButton) {
        //personDetails.phone.removeLast()
        let point = sender.convert(CGPoint.zero, to: myTable)
        guard let indexPath = myTable.indexPathForRow(at: point) else {return}
//        let cell = myTable.cellForRow(at: indexPath) as! CellPhoneTypeModify
        //let phoneType = cell.lblPhoneType.text!

        personDetails.phone.remove(at: indexPath.row-1)
        // let selectedPhoneType: PhoneRow = personDetails.phone/*.filter({$0.PhoneType == phoneType}).first!*/
        //if selectedPhoneType != nil {
        // selectedPhoneType.DisplayStatus = false
        //}
        myTable.reloadData()
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



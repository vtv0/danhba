//
//  SuaVC12.swift
//  Contacts
//
//  Created by Vuong The Vu on 16/08/2022.
//

import UIKit
class SuaVC12: UIViewController , UITableViewDataSource {
    var imagePicker = UIImagePickerController()
    var item: Person!
    var selectedImage: UIImage!
    var selectedImageName: String!
    
    var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    var phoneRows: [PhoneRow] = [
        PhoneRow(phoneNumber: "", phoneType: "1di động", displayStatus: true),
        PhoneRow(phoneNumber: "", phoneType: "2nhà", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "3công ty", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "4trường học", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "5chính", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "6fax công ty", displayStatus: false)
    ]
    
    @IBAction func btnHuyMHSua(_ sender: Any) {
        self.dismiss(animated: true)
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
        let cell = myTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! CellModify
        //print("txtName", cell.txtName.text)
        let cell1 = myTable.cellForRow(at: IndexPath(row: 1, section: 1)) as! CellPhoneTypeModify
        //print("txtPhoneNumber", cell1.txtPhoneNumber.text)
        let cell2 = myTable.cellForRow(at: IndexPath(row: 0, section: 2)) as! CellModify
        //print("txtEmail", cell2.txtEmail.text)
        let cell3 = myTable.cellForRow(at: IndexPath(row: 0, section: 3)) as! CellModify
        //print("txtCompany", cell3.txtCompany.text)
        let cell4 = myTable.cellForRow(at: IndexPath(row: 0, section: 4)) as! CellModify
        //print("txtDOB", cell4.txtDOB.text)
        let cell5 = myTable.cellForRow(at: IndexPath(row: 0, section: 5)) as? CellModify
           
            
            //print("txtID", cell5.txtID.text)
        
        print(item.ID)
        if (cell.txtName.text != "" || cell5?.txtID.text != "") {
            
            selectedImageName = self.save(image: selectedImage)
            
            let item = Person(id: cell5?.txtID.text ?? "", images: selectedImageName, name: cell.txtName.text ?? "", phonenumber: cell1.txtPhoneNumber.text ?? "", email: cell2.txtEmail.text ?? "", company: cell3.txtCompany.text ?? "", dateofbirth: cell4.txtDOB.text ?? "")
            
            self.dismiss(animated: true)
            
            //  phat tin hieu de sua
            let dataToPass:[String: Person] = ["details": item]
            let nc = NotificationCenter.default;
            nc.post(name: Notification.Name("TestNotification"), object: nil , userInfo: dataToPass)
        }
            
    }
    
    @IBAction func onNameChange(_ sender: UITextField) {
        print("S",sender.text)
       var name = sender.text
        name = item.Name
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return  1
            
        } else if (section == 1) {
            return phoneRows.filter({$0.DisplayStatus == true}).count + 1
            
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellName") as! CellModify
            cell.txtName.text = item.Name
            return cell
        } else if (indexPath.section == 1) {
            if(indexPath.row == 0) {
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneAdd") as! CellPhoneTypeModify
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellPhoneType") as! CellPhoneTypeModify
                let visibleRecords = phoneRows.filter({$0.DisplayStatus == true})
                let item1 = visibleRecords[indexPath.row - 1 ]
                cell.lblPhoneType.text = item1.PhoneType
                cell.txtPhoneNumber.text = item.PhoneNumber
                
                return cell
            }
        } else if (indexPath.section == 2) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellEmail") as! CellModify
            cell.txtEmail.text = item.Email
            return cell
        } else if (indexPath.section == 3) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellCompany") as! CellModify
            cell.txtCompany.text = item.Company
            return cell
        } else if (indexPath.section == 4) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellDOfB") as! CellModify
            cell.txtDOB.text = item.DateOfBirth
            return cell
        } else if (indexPath.section == 5) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellModify
            
            cell.txtID.text = item.ID
            print("id", item.ID)
            
            return cell
        } else {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellModify
            
            return cell
        }
    }
    
    @IBAction func AddRow(_ sender: Any) {
        let hiddenRecords = phoneRows.filter({$0.DisplayStatus == false})
        if !hiddenRecords.isEmpty {
            let recordToBeInsert:PhoneRow = hiddenRecords.first!
            recordToBeInsert.DisplayStatus = true
            myTable.performBatchUpdates({
                myTable.insertRows(at: [IndexPath(row: 0, section: 1)], with: .left)
            })
            myTable.reloadData()
        }
    }
    
    @IBAction func btnDeleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myTable)
        guard let indexPath = myTable.indexPathForRow(at: point) else {return}
        let cell = myTable.cellForRow(at: indexPath) as! CellPhoneTypeModify
        let phoneType = cell.lblPhoneType.text!
        let selectedPhoneType: PhoneRow = phoneRows.filter({$0.PhoneType == phoneType}).first!
        if selectedPhoneType != nil {
            selectedPhoneType.DisplayStatus = false
        }
        myTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chi tiết sửa"
        myTable.dataSource = self
        
        imgHinh.layer.cornerRadius = imgHinh.frame.width / 2
        imgHinh.clipsToBounds = true
        selectedImage = self.load(fileName: item!.Images)
        imgHinh.image = selectedImage
    }
    
    private func save(image: UIImage!) -> String? {
        if (image != nil) {
            let fileName = "FileName"
            let fileURL = documentsURL.appendingPathComponent(fileName)
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                try? imageData.write(to: fileURL, options: .atomic)
                print("aaa\(fileName)")
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
        guard let imageUrl = info[.imageURL] as? URL else {
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



//
//  MH1ThemMoi.swift
//  Contacts
//
//  Created by Vuong The Vu on 18/08/2022.
//

import UIKit

class MH1ThemMoi: UIViewController , UITableViewDataSource {
    @IBOutlet weak var selectedImageImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var myTable: UITableView!
    
    var phoneRows: [PhoneRow] = [
        PhoneRow(phoneNumber: "", phoneType: "1di động", displayStatus: true),
        PhoneRow(phoneNumber: "", phoneType: "2nhà", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "3công ty", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "4trường học", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "5chính", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "6fax công ty", displayStatus: false)
    ]
    
    var personDetails: Person!
    var selectedImage: UIImage!
    var selectedImageName: String!
    
    var documentsURL: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
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
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        let cell = myTable.cellForRow(at: IndexPath(row: 0, section: 0)) as! CellName
        //print("txtName", cell.txtName.text)
        
        let cell1 = myTable.cellForRow(at: IndexPath(row: 1, section: 1)) as! CellPhoneType
        //print("txtPhoneNumber", cell1.txtPhoneNumber.text)
        
        let cell2 = myTable.cellForRow(at: IndexPath(row: 0, section: 2)) as! CellEmail
        //print("txtEmail", cell2.txtEmail.text)
        
        let cell3 = myTable.cellForRow(at: IndexPath(row: 0, section: 3)) as! CellCompany
        //print("txtCompany", cell3.txtCompany.text)
        
        let cell4 = myTable.cellForRow(at: IndexPath(row: 0, section: 4)) as! CellDofB
        //print("txtDOB", cell4.txtDOB.text)
        
        if let cell5 = myTable.cellForRow(at: IndexPath(row: 0, section: 5)) as? CellId {
            
        }
        //print("txtID", cell5.txtID.text)
        
        if (cell.txtName.text != "") {
            print("nhay vao xong MH Them moi")
            
            selectedImageName = self.save(image: selectedImage)
            
            let personDetails = Person(id: randomString(length: 6), images: selectedImageName, name: cell.txtName.text ?? "", phonenumber: cell1.txtPhoneNumber.text ?? "" , email: cell2.txtEmail.text ?? "", company: cell3.txtCompany.text ?? "", dateofbirth: cell4.txtDOB.text ?? "")
            
            self.dismiss(animated: true)
            
            //phat tin hieu de them moi
            let notification = NotificationCenter.default
            notification.post(name: Notification.Name("UseNoti"), object: personDetails , userInfo: ["details" : personDetails])
            print("111a: \(personDetails)")
            print(personDetails)
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
        let cell = myTable.cellForRow(at: indexPath) as! CellPhoneType
        let phoneType = cell.lblPhoneType.text!
        let selectedPhoneType: PhoneRow = phoneRows.filter({$0.PhoneType == phoneType}).first!
        if selectedPhoneType != nil {
            selectedPhoneType.DisplayStatus = false
        }
        myTable.reloadData()
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
            
        } else if (section  == 1) {
            return phoneRows.filter({$0.DisplayStatus == true}).count + 1
            
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellName") as! CellName
            return cell
        }else if indexPath.section == 1 {
            if (indexPath.row == 0) {
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneAdd") as! CellPhoneAdd
                return cell
            } else {
                let cell = myTable.dequeueReusableCell(withIdentifier: "CellPhoneType") as! CellPhoneType
                let visibleRecords = phoneRows.filter({$0.DisplayStatus == true})
                let item = visibleRecords[indexPath.row - 1 ]
                cell.lblPhoneType.text = item.PhoneType
                cell.txtPhoneNumber.text = item.PhoneNumber
                
                
                return cell
            }
        }else if (indexPath.section == 2) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellEmail") as! CellEmail
            return cell
        }else if (indexPath.section == 3) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellCompany") as! CellCompany
            return cell
        } else if  (indexPath.section == 4) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellDOfB") as! CellDofB
            return cell
        }
        else if  (indexPath.section == 5) {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellId") as! CellId
            return cell
        }
        else {
            let cell = myTable.dequeueReusableCell(withIdentifier: "CellName")
            return cell!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
}



extension MH1ThemMoi: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let imageUrl = info[.imageURL] as? URL else {
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



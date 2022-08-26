//
//  MH3ViewController.swift
//  Contacts
//
//  Created by Vuong The Vu on 22/08/2022.
//

import UIKit


class MH3ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var phonerow: [PhoneRow] = [
        PhoneRow(phoneNumber: "", phoneType: "1di động", displayStatus: true),
        PhoneRow(phoneNumber: "", phoneType: "2nhà", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "3công ty", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "4trường học", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "5chính", displayStatus: false),
        PhoneRow(phoneNumber: "", phoneType: "6fax công ty", displayStatus: false)
    ]
    
    @IBOutlet weak var myTable: UITableView!
    
    @IBAction func btnXong(_ sender: Any) {
        dismiss(animated: true)
        print("xong MHsua ")
    }
    
    
    @IBAction func btnAddRow(_ sender: Any) {
//        phonerow.append(PhoneRow(phoneNumber: "", phoneType: "7khác", displayStatus: true))
        
        let hiddenRecords = phonerow.filter({$0.DisplayStatus == false})
        if !hiddenRecords.isEmpty {
            let recordToBeInsert:PhoneRow = hiddenRecords.first!
            recordToBeInsert.DisplayStatus = true
            myTable.performBatchUpdates({
                myTable.insertRows(at: [IndexPath(row: 0  , section: 0)], with: .left)
            })
            myTable.reloadData()
        }
    }
    
    
    @IBAction func btnDeleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: myTable)
        guard let indexPath = myTable.indexPathForRow(at: point) else {return}
        let cell = myTable.cellForRow(at: indexPath) as! SecondTableCellMH3
        let phoneType = cell.lblPhoneAddress.text!
        let selectedPhoneType: PhoneRow = phonerow.filter({$0.PhoneType == phoneType}).first!
        if selectedPhoneType != nil {
            selectedPhoneType.DisplayStatus = false
        }
        myTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if (indexPath.row == 0) {
                print("section \(indexPath.section) row \(indexPath.row) show + thêm SDT")
                let cell = myTable.dequeueReusableCell(withIdentifier: "CELL")  as! CellMh3
                return cell
            } else {
                print( "section 0 row \(indexPath.row)")
                let cell = myTable.dequeueReusableCell(withIdentifier: "SecondTableCellMH3") as! SecondTableCellMH3
                let visibleRecords = phonerow.filter({$0.DisplayStatus == true})
                let item = visibleRecords[indexPath.row - 1]
                cell.lblPhoneAddress.text = item.PhoneType
                cell.txtPhoneNumber.text = item.PhoneNumber
                return cell
            }
            
        } else {  //sang section khac vd section 1
            let cell = myTable.dequeueReusableCell(withIdentifier: "CELL")
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return phonerow.filter({$0.DisplayStatus == true}).count + 1
        } else  {
            return 1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
       
        myTable.delegate = self
    }
    
    
}

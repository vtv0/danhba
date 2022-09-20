//
//  DBManager.swift
//  Contacts
//
//  Created by Vuong The Vu on 19/09/2022.
//

import Foundation
import RealmSwift


class PhoneRow: Object {
    @Persisted var dislayStatus : Bool
    @Persisted var phoneType : String = ""
    @Persisted var phoneNumber: String = ""
    
    //khai bao lop chua cac doi tuong
    class Person : Object {
        @objc dynamic var id:Int = 0
        @objc dynamic var name: String = ""
        @objc dynamic var email: String = ""
        @objc dynamic var company: String = ""
        @objc dynamic var dob: String = ""
        //var phones = List<PhoneRow>
        
        //danh dau la khoa chinh
        func primaryKey() -> String {
            return "id"
        }
    }
    
    //khai bao lop quan ly co so du lieu
    class DBManager  {
        //bien tham chieu toi co so du lieu Realm
        private var database: Realm
        
        //bien chua thuc the duy nhat cua lop DBManager trong taon bo chuong trinh
        static var shareInstance = DBManager()
        static var autoID: Int = 0
        
        
        //luu lai thong so id vao UserDefault data
        let userData: UserDefaults!
        
        
        //ham khoi tao
        private init() {
            //khoi tao database realm
            database = try! Realm()
            
            
            //khoi tao userData doc thong so ID
            userData = UserDefaults.standard
            DBManager.autoID = userData.integer(forKey: "autoID")
        }
        
        //ham lay toan bo SCDL trong Realm
        func getDataFromDB() -> Results<Person> {
            let result: Results<Person> = database.objects(Person.self)
            return result
        }
        
        
        
        //ham insert du lieu vao
        func addData(object: Person) {
            try! database.write {
                DBManager.autoID += 1
                object.id = DBManager.autoID
                
                
                database.add(object)
                //luu lai thong tin auto ID hien thi vao userData
                userData.set(DBManager.autoID, forKey: "autoID")
                
                print("them du lieu ok")
            }
        }
        
        
        //ham xoa mot phan tu
        func deleteItemFromDB(object: Person) -> Bool {
            do {
                try database.write({
                    database.delete(object)
                })
                return true
            } catch {
                return false
                
            }
            
        }
        
        //cap nhap thong tin mot phan tu
        func updateToDB(object: Person) -> Bool {
            do {
                try database.write({
                    // database.add(object, update: true)
                })
                return true
            }catch {
                return false
            }
        }
        
    }
}

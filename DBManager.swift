//
//  DBManager.swift
//  Contacts
//
//  Created by Vuong The Vu on 19/09/2022.
//

import Foundation
import RealmSwift



class PhoneRow: Object {
//    @Persisted var displayStatus : Bool = false
    @Persisted var phoneType : String = ""
    @Persisted var phoneNumber: String = ""
}
    
    //khai bao lop chua cac doi tuong
class Person : Object {
    @Persisted var id = UUID().uuidString
    @Persisted var image: String = ""
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var company: String = ""
    @Persisted var dob: String = ""
    
    @Persisted var phone: List<PhoneRow>
    
//    @Persisted var phone: [PhoneRow] =  [
//        PhoneRow(phoneNumber: "", phoneType: "mobile", displayStatus: true),
//            PhoneRow(phoneNumber: "", phoneType: "home", displayStatus: false),
//            PhoneRow(phoneNumber: "", phoneType: "company", displayStatus: false),
//            PhoneRow(phoneNumber: "", phoneType: "school", displayStatus: false),
//            PhoneRow(phoneNumber: "", phoneType: "main", displayStatus: false),
//            PhoneRow(phoneNumber: "", phoneType: "company fax", displayStatus: false)
//        ]
    
    
    
    //danh dau la khoa chinh
    func primaryKey() -> String {
        return "id"
    }
}



extension RealmCollection {
    func toArray<PhoneRow>() -> [PhoneRow] {
        return self.compactMap{$0 as? PhoneRow}
    }
}
//let stringList = Person.phone.toArray()



    
    //khai bao lop quan ly co so du lieu
    class DBManager  {
        //bien tham chieu toi co so du lieu Realm
        private var database: Realm

        //bien chua thuc the duy nhat cua lop DBManager trong taon bo chuong trinh
        static var shareInstance = DBManager()
        static var autoID = UUID().uuidString


        //luu lai thong so id vao UserDefault data
        let userData: UserDefaults!


        //ham khoi tao
        private init() {
            //khoi tao database realm
            database = try! Realm()

            let configuration = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 1 {

                        
                    }
                }
            )
            
            Realm.Configuration.defaultConfiguration = configuration
            // opening the Realm file now makes sure that the migration is performed
            let realm = try! Realm()
            

            //khoi tao userData doc thong so ID
            userData = UserDefaults.standard
            DBManager.autoID = userData.string(forKey: "autoID") ?? ""
        }

        //ham lay toan bo SCDL trong Realm
        func getDataFromDB() -> Results<Person> {
            let result: Results<Person> = database.objects(Person.self)
            return result
        }

        //ham them du lieu vao
        func addData(object: Person) {
            try! database.write {
               // DBManager.autoID += 1
                object.id = UUID().uuidString

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


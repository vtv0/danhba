//
//  AppDelegate.swift
//  Contacts
//
//  Created by Vuong The Vu on 19/07/2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        let configuration = Realm.Configuration(
        //            schemaVersion: 1,
        //            migrationBlock: { migration, oldSchemaVersion in
        //                if oldSchemaVersion < 1 {
        //
        //                    // if just the name of your model's property changed you can do this
        //                    migration.renameProperty(onType: Person.className(), from: "text", to: "title")
        //
        //                    // if you want to fill a new property with some values you have to enumerate
        //                    // the existing objects and set the new value
        //                    migration.enumerateObjects(ofType: PhoneRow.className()) { oldObject, newObject in
        //                        let text = oldObject!["text"] as! String
        //                        newObject!["textDescription"] = "The title is \(text)"
        //                    }
        //
        //                    // if you added a new property or removed a property you don't
        //                    // have to do anything because Realm automatically detects that
        //                }
        //            }
        //        )
        //        Realm.Configuration.defaultConfiguration = configuration
        //
        //        // opening the Realm file now makes sure that the migration is performed
        //        let realm = try! Realm()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}


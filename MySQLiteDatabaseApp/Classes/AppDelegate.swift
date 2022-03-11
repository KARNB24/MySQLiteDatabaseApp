//
//  AppDelegate.swift
//  MySQLiteDatabaseApp
//
//  Created by  on 2022-03-09.
//

import UIKit
import SQLite3


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var databaseName : String? = "MyDatabase.db"
    var databasePath : String?
    var people : [Data] = []
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)
        
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        return true
    }
    
    func readDataFromDatabase(){
        people.removeAll()
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            
            print("Successfully opened connection to database at \(self.databasePath!)")
            
            var queryStatement : OpaquePointer? = nil
            var queryStatementString : String = "select * from entries"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK
            {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW
                {
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let cemail = sqlite3_column_text(queryStatement, 2)
                    let cfood = sqlite3_column_text(queryStatement, 3)
                    
                    let name = String(cString: cname!)
                    let email = String(cString: cemail!)
                    let food = String(cString: cfood!)
                    
                    let data : Data = Data.init()
                    data.initWithData(theRow: id, theName: name, theEmail: email, theFood: food)
                    people.append(data)
                    
                    print("Query result")
                    print("\(id) | \(name) | \(email) | \(food)")
                    
                
                }
                sqlite3_finalize(queryStatement)
            }
            else
            {
                print("Select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        }
        else {
            print("Unable to open database")
        }
    }
    
    func checkAndCreateDatabase(){
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success {
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
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


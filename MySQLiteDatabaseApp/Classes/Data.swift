//
//  Data.swift
//  MySQLiteDatabaseApp
//
//  Created by  on 2022-03-09.
//

import UIKit

class Data: NSObject {
    var id : Int?
    var name: String?
    var email:String?
    var food : String?
    
    func initWithData(theRow i : Int, theName n : String, theEmail e : String, theFood f : String) {
        id = i
        name = n
        email = e
        food = f
    }
}

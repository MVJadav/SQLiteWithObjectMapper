//
//  SQLQuery.swift
//  ContactList
//
//  Created by Mac33 on 02/01/17.
//  Copyright © 2017 JadavMehul. All rights reserved.
//

import Foundation
import UIKit

///MARK: - SqlLite Database Parameter
class DatabaseParameter {
    
    static let DBNameContact    = "contact"
    static let DBNameUser       = "user"
}

///MARK: - SqlLite Tables Parameter
class TableName{
    static let Contact  = "contact"
    static let User     = "userDetail"
}

class createTable{
    static let contactTable     = "CREATE TABLE IF NOT EXISTS \(TableName.Contact) ( user_id integer primary key autoincrement, FirstName TEXT, LastName TEXT, MobileNumber TEXT, PhoneNumber TEXT, Address TEXT, DOB text, Image TEXT );"
    static let userTable        = "create table if not exists \(TableName.User) (userid integer primary key, fname text,lname text, company text, home text, phone text,mobile text, email text,address text, image text, ringtone text, birthday text, note text)"
}

class SQLQuery {
    
//MARK: - SqlLite Select Queries
    class Select{
        static let SelectContact    = "select * from \(TableName.Contact) ORDER BY FirstName ASC"
        static let SelectUser       = "select * from \(TableName.User) ORDER BY fname ASC"
    }

//MARK: - SqlLite Insert Queries
    class func insert<T>(Obj: T) -> String{
        
        var insertSQL : String = ""
        if(Obj is ContactModel){
            
            let objContact = Obj as! ContactModel;
            insertSQL = "insert into \(TableName.User) (fname,lname,company,home,phone,mobile,email,address,image,ringtone,birthday,note) values(\"\(objContact.FirstName!)\",\"\(objContact.LastName!)\", \"\("")\", \"\("")\",\"\(objContact.PhoneNumber!)\",\"\(objContact.MobileNumber!)\",\"\("")\", \"\("")\", \"\(objContact.Image!)\",\"\("")\",\"\(objContact.DOB!)\",\"\("")\")"
        }
        return insertSQL
    }
    
//MARK: - SqlLite Update Queries
    class func update<T>(Obj: T) -> String{
        
        var editSQL : String = ""
        if(Obj is ContactModel){
            
            let objContact = Obj as! ContactModel;
            
            editSQL = "update \(TableName.User) set fname = '\(objContact.FirstName!)',lname = '\(objContact.LastName!)',company = '\("")',home = '\("")',phone = '\(objContact.PhoneNumber!)',mobile = '\(objContact.MobileNumber!)',email = '\("")',address = '\("")',image = '\(objContact.Image!)',ringtone = '\("")',birthday = '\(objContact.DOB!)',note = '\("")' where userid = \(objContact.UserID!) "
        }
        return editSQL
    }
    
//MARK: - SqlLite Delete Queries
    class func delete<T>(Obj: T) -> String{
        
        var deleteSQL : String = ""
        if(Obj is ContactModel){
            let objContact = Obj as! ContactModel;
            deleteSQL = "Delete from \(TableName.User) where userid = \(objContact.UserID!)"
        }
        return deleteSQL
    }
}


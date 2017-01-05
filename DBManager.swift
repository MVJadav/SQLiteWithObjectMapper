//
//  DBManager.swift
//  ContactList
//
//  Created by Mac33 on 02/01/17.
//  Copyright © 2017 JadavMehul. All rights reserved.
//

import Foundation

var sharedInstance  : DBManager? = nil
var database        : OpaquePointer? = nil
var databasePath    : String!

class DBManager : NSObject{
    var isSuccess = true
    
    class func getSharedInstance() -> DBManager {
        if sharedInstance == nil {
            sharedInstance = DBManager()
            sharedInstance!.createDB()
        }
        return sharedInstance!
    }
    
    func createDB() -> Bool {
        var docsDir     : String
        var dirPaths    : [Any]
        // Get the documents directory
        dirPaths    = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        docsDir     = dirPaths[0] as! String
        print("Directory Path: ",docsDir)
        // Build the path to the database file
        databasePath = String(URL(fileURLWithPath: docsDir).appendingPathComponent("\(DatabaseParameter.DBNameUser).db").absoluteString)
        //BOOL isSuccess = YES;
        let filemgr = FileManager.default
        
        if filemgr.fileExists(atPath: databasePath) == false {
            
            let dbpath = databasePath
            //let data = string.data(using: String.Encoding.utf8)!
            if sqlite3_open(dbpath, &database) == SQLITE_OK {
                //var errMsg: CChar!
                var errMsg:UnsafeMutablePointer<Int8>? = nil
                if sqlite3_exec(database, createTable.userTable, nil, nil, &errMsg) != SQLITE_OK {
                    isSuccess = false
                    print("Failed to create table")
                }
                sqlite3_close(database)
                return isSuccess
            }
            else {
                isSuccess = false
                print("Failed to open/create database")
            }
        }
        return isSuccess
    }
}

extension DBManager {
    
    //MARK: Insertion records
    func insert(queryString: String) -> Bool {
        
        var statement: OpaquePointer? = nil
        let dbpath = databasePath
        var success: Bool
        if sqlite3_open(dbpath, &database) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                // Read the data from the result row
            }
            // Release the compiled statement from memory
            sqlite3_finalize(statement)
        }
        let insert_stmt = queryString
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
            success = true
        }
        else {
            success = false
        }
        sqlite3_finalize(statement)
        sqlite3_close(database);
        return success
    }
    
    //MARK: Updation records
    func update(queryString: String) -> Bool {

        var statement: OpaquePointer? = nil
        let dbpath = databasePath
        var success: Bool
        if sqlite3_open(dbpath, &database) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                // Read the data from the result row
            }
            // Release the compiled statement from memory
            sqlite3_finalize(statement)
        }
        let insert_stmt = queryString
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
            success = true
        }
        else {
            success = false
        }
        sqlite3_finalize(statement)
        sqlite3_close(database);
        return success
    }
    
    //MARK: Selection records
    func select(strQuery: String) -> NSMutableArray {
        
        var statement: OpaquePointer?   = nil
        let dbpath                      = databasePath
        let arrayList: NSMutableArray   = NSMutableArray()
        
        if sqlite3_open(dbpath, &database) == SQLITE_OK {
            let querySQL = strQuery
            let query_stmt = querySQL
            if sqlite3_prepare_v2(database, query_stmt, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    var i: CInt = 0;
                    var iColumnCount:CInt = 0
                    iColumnCount = sqlite3_column_count(statement)
                    let dict: NSMutableDictionary = NSMutableDictionary()
                    while i < iColumnCount {
                        let str = sqlite3_column_text(statement, i)
                        let strFieldName = String(cString:sqlite3_column_name(statement, i), encoding:String.Encoding.utf8)
                        dict.setValue(String(cString: str!), forKey: strFieldName!);
                        i += 1;
                    }
                    arrayList.add(dict);
                }
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(database);
        return arrayList;
    }
    
    //MARK: Deletion records
    func delete(strQuery: String) -> Bool {
        
        let dbpath = databasePath
        var statement: OpaquePointer? = nil
        var success: Bool
        let update_stmt = strQuery
        if (sqlite3_open(dbpath, &database) == SQLITE_OK){
            sqlite3_prepare_v2(database, update_stmt, -1, &statement, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                success = true
            }
            else {
                success = false
            }
        }else{
            success = false
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
        return success
    }
}

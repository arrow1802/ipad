//
//  DBHelper.swift
//  ipad1
//
//  Created by arrow on 5/19/20.
//  Copyright © 2020 arrow. All rights reserved.
//

import Foundation
import SQLite3


class DBHelper{
    
    init() {
        dbCred = openDatabase(dbPath: credDbPath)
        dbExistAppDB = openExistDatabase(dbPath: existAppDB)
        createTable(db: dbCred!)
//        insertUser(db: dbCred!, Id: 5, emailId: "user5", password: "1234")
//        insertUser(Id: 2, emailId: "user2@mail.com", password: "MTIzcXdlYXNk")
//        insertUser(Id: 3, emailId: "user3@mail.com", password: "123qweasd")
//        readUser(db: dbCred!)
//        readQuery(db: dbExistAppDB!, query: "SELECT ZTEXT FROM ZWAMESSAGE;")
//        readOneUser(_emailId: "user1", _password: "123")
//        let res = readOneUser(emailId: "user1@mail.com")
//        for i in res {
//            print(i.password)
//        }
    }
    
    let credDbPath: String = "ipad.sqlite3"
    let existAppDB: String = "App_1.sqlite"
    var dbCred:OpaquePointer?
    var dbExistAppDB:OpaquePointer?
    
    func openDatabase(dbPath : String) -> OpaquePointer? {
//        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        let fileUrl = Bundle.main.path(forResource: "ipad", ofType: ".sqlite")
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileUrl, &db) != SQLITE_OK {
            print("error opening database file.")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            print(sqlite3_open(fileUrl, &db))
            return db
        }
        
    }
    
    func openExistDatabase(dbPath : String) -> OpaquePointer? {
//        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        
        let fileUrl = Bundle.main.path(forResource: "App_1", ofType: ".sqlite")
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileUrl, &db) != SQLITE_OK {
            print("error opening database file.")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
        
    }
    
    func createTable(db:OpaquePointer) {
        
        let createTableString = """
CREATE TABLE IF NOT EXISTS entryPoint(Id INTEGER PRIMARY KEY,emailId TEXT,password TEXT);
"""
        var createTableStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil ) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Entrypoint Table Created.",SQLITE_DONE)
            } else {
                print("EntryPoint Table could not be created.")
            }
        } else {
            print("Created table statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
        
    }
    
    func insertUser(db:OpaquePointer,Id:Int,emailId:String,password:String) {
        
        let clients = readUser(db:db)
        for c in clients{
            if c.id == Id {
                return
            }
        }
        
        let insertStatementString = "INSERT INTO entryPoint (Id,emailId,password) VALUES (?,?,?);"
        var insertStatement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(Id))
            sqlite3_bind_text(insertStatement, 2, (emailId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted rowID : \(Id) ")
            } else {
                print("Could not insert rowID : \(Id)")
            }
        } else {
            print("Insert Statement could not be prepared.")
        }
        
        sqlite3_finalize(insertStatement)
        
    }
    
    
    func readUser(db:OpaquePointer) -> [USER] {
        let queryStatementString = "SELECT * FROM entryPoint;"
        var queryStatement:OpaquePointer? = nil
        var client:[USER] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let emailId = sqlite3_column_text(queryStatement, 1) != nil ? String(describing: String(cString: sqlite3_column_text(queryStatement, 1))) : ""
                let password = sqlite3_column_text(queryStatement, 2) != nil ? String(describing: String(cString: sqlite3_column_text(queryStatement, 2))) : ""
                
                client.append(USER(id: Int(id),emailId: emailId,password: password))
                print("\(id) | \(emailId) | \(password)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return client
    }

    func readOneUser(_emailId:String,_password:String) -> Bool{
        let queryStatementString = "SELECT * FROM entryPoint WHERE emailId = '\(_emailId)' and password ='\(_password)';"
        print(queryStatementString)
        var queryStatement:OpaquePointer? = nil
        var client:[USER] = []
        var res:Bool = false
        if sqlite3_prepare_v2(dbCred, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let emailId = sqlite3_column_text(queryStatement, 1) != nil ? String(describing: String(cString: sqlite3_column_text(queryStatement, 1))) : ""
                let password = sqlite3_column_text(queryStatement, 2) != nil ? String(describing: String(cString: sqlite3_column_text(queryStatement, 2))) : ""
                client.append(USER(id: Int(id),emailId: emailId,password: password))
                print("\(id) | \(emailId) | \(password)")
                if (_emailId==emailId && _password==password) {
                    print("true")
                    res = true
                } else {
                    res = false
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return res
    }
    
    func readQuery(db:OpaquePointer,query:String) -> [WAMSG]{
        let queryStatementString = "SELECT Z_PK,ZTEXT FROM ZWAMESSAGE"
        var queryStatement:OpaquePointer? = nil
        var Msgs:[WAMSG] = []
//        var Msgs:Array<Any> = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                var text = ""
                if sqlite3_column_text(queryStatement, 1) != nil {
                    text = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                }
//
                
                Msgs.append(WAMSG(id : Int(id),text:text))
                print("---------------------------------")
                print("\(id) | \(text)")
            }
        } else {
            print("SELECT statement could not be prepared",sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil))
        }
        sqlite3_finalize(queryStatement)
        
        return Msgs
    }
    
}

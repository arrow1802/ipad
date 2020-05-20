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
        db = openDatabase()
        createTable()
//        insertUser(Id: 1, emailId: "user1@mail.com", password: "123")
        let res = readOneUser(emailId: "user1@mail.com")
        for i in res {
            print(i.password)
        }
    }
    
    let dbPath: String = "ipad.sqlite3"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer? {
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK {
            print("error opening database file.")
            return nil
        } else {
            print("Successfully opened connection to database at \(dbPath)")
            print(sqlite3_open(fileUrl.path, &db))
            return db
        }
        
    }
    
    func createTable() {
        
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
    
    func insertUser(Id:Int,emailId:String,password:String) {
        
        let clients = readUser()
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
    
    
    func readUser() -> [USER]{
        let queryStatementString = "SELECT * FROM entryPoint;"
        var queryStatement:OpaquePointer? = nil
        var client:[USER] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let emailId = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                client.append(USER(id: Int(id),emailId: emailId,password: password))
                print("Query Result")
                print("\(id) | \(emailId) | \(password)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return client
    }
    
    func readOneUser(emailId:String) -> [USER]{
        let queryStatementString = "SELECT * FROM entryPoint WHERE emailId = '\(emailId)';"
        var queryStatement:OpaquePointer? = nil
        var client:[USER] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let emailId = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                client.append(USER(id: Int(id),emailId: emailId,password: password))
                print("Query Result")
                print("\(id) | \(emailId) | \(password)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        
        return client
    }
    
}

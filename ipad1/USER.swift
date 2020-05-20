//
//  USER.swift
//  ipad1
//
//  Created by arrow on 5/20/20.
//  Copyright © 2020 arrow. All rights reserved.
//

import Foundation

class USER
{
    var emailId:String = ""
    var password:String=""
    var id:Int = 0
    
    
    init(id:Int,emailId:String,password:String){
        self.id = id
        self.emailId = emailId
        self.password = password
    }
}

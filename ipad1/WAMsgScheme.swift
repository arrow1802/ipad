//
//  WAMsgScheme.swift
//  ipad1
//
//  Created by arrow on 5/20/20.
//  Copyright © 2020 arrow. All rights reserved.
//

import Foundation

class WAMSG
{
    var id :Int = 0
    var text:String?
    
    
    init(id:Int,text:String?){
        self.text = text
        self.id = id
    }
}

class userResult{
    var data:Array<Any>
    var error:Bool
    
    init(data:Array<Any>,error:Bool) {
        self.data = data
        self.error = error
    }
}

//
//  GenericQueryable.swift
//  KeychainService
//
//  Created by Thaliees on 1/20/20.
//  Copyright © 2020 Thaliees. All rights reserved.
//

import Foundation

/// Option 1
// You can create a structure where you will not change the name of the service and the group
/*public struct GenericQueryable {
    let service = "KeychainService"
    //let accessGroup = "[Insert your App ID Prefix].[Insert your Bundle Identifier]"
}*/

/// Option 2
// Or create a structure where you indicate those variables

public struct GenericQueryable {
    let service: String
    let accessGroup: String?
    
    init(service: String, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }
}

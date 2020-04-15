//
//  GenericQueryableExtension.swift
//  KeychainService
//
//  Created by Thaliees on 1/20/20.
//  Copyright © 2020 Thaliees. All rights reserved.
//

import Foundation

// Implement the defined protocol (SecureStoreQueryable)
extension GenericQueryable: SecureStoreQueryable {
    public var query: [String : Any] {
        var query = [String: Any]()
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        //query[String(kSecAttrAccessGroup)] = accessGroup
        
        return query
    }
}

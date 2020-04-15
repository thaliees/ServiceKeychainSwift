//
//  SecureStore.swift
//  KeychainService
//
//  Created by Thaliees on 1/20/20.
//  Copyright © 2020 Thaliees. All rights reserved.
//

import Foundation
import Security

struct SecureStore {
    let secureStoreQueryable: SecureStoreQueryable
    
    public init(secureStoreQueryable: SecureStoreQueryable) {
        self.secureStoreQueryable = secureStoreQueryable
    }
    
    public func setValue(_ value: String, for userAccount: String) throws {
        guard let encodedValue = value.data(using: .utf8) else {
            throw SecureStoreError.string2DataConversionError
        }
        
        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = userAccount
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            // Update value
            var attrUpdate: [String: Any] = [:]
            attrUpdate[String(kSecValueData)] = encodedValue
            
            status = SecItemUpdate(query as CFDictionary, attrUpdate as CFDictionary)
            if status != errSecSuccess { throw error(from: status) }
            
        case errSecItemNotFound:
            // Add value
            query[String(kSecValueData)] = encodedValue
            
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess { throw error(from: status) }
        
        default:
            throw error(from: status)
        }
    }
    
    public func getValue(for userAccount: String) throws -> String? {
        var query = secureStoreQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(kSecAttrAccount)] = userAccount
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        switch status {
        case errSecSuccess:
            guard let result = queryResult as? [String: Any] else { throw SecureStoreError.unexpectedItemData }
            
            guard let passwordResult = result[String(kSecValueData)] as? Data,
            let password = String(data: passwordResult, encoding: .utf8) else { throw SecureStoreError.data2StringConversionError }
            return password
            
        case errSecItemNotFound: return nil
        
        default:
            throw error(from: status)
        }
    }
    
    public func getValues() throws -> [String] {
        var query = secureStoreQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchItemList
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanFalse
        query[String(kSecAttrAccount)] = "value1"
        
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        switch status {
        case errSecSuccess:
            guard let result = queryResult as? [[String: Any]] else { throw SecureStoreError.unexpectedItemData }
            
            var items = [String]()
            for itemResult in result {
                guard let passwordResult = itemResult[String(kSecValueData)] as? Data,
                let password = String(data: passwordResult, encoding: .utf8) else { throw SecureStoreError.data2StringConversionError }
                items.append(password)
            }
            
            return items
            
        case errSecItemNotFound: return [String]()
        
        default:
            throw error(from: status)
        }
    }
    
    public func removeValue(for userAccount: String) throws {
      var query = secureStoreQueryable.query
      query[String(kSecAttrAccount)] = userAccount
      
      let status = SecItemDelete(query as CFDictionary)
      guard status == errSecSuccess || status == errSecItemNotFound else {
        throw error(from: status)
      }
    }
    
    public func removeAllValues() throws {
      let query = secureStoreQueryable.query
      
      let status = SecItemDelete(query as CFDictionary)
      guard status == errSecSuccess || status == errSecItemNotFound else {
        throw error(from: status)
      }
    }
    
    mutating func renameAccount(_ newAccountName: String) throws {
        let query = secureStoreQueryable.query
        
        // Try to update an existing item with the new account name.
        var attrToUpdate = [String : Any]()
        attrToUpdate[String(kSecAttrAccount)] = newAccountName
        
        let status = SecItemUpdate(query as CFDictionary, attrToUpdate as CFDictionary)
        if status != errSecSuccess { throw error(from: status) }
    }
    
    private func error(from status: OSStatus) -> SecureStoreError {
      let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
      return SecureStoreError.unhandledError(message: message)
    }
}

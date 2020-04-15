//
//  SecureStoreQueryable.swift
//  KeychainService
//
//  Created by Thaliees on 1/20/20.
//  Copyright © 2020 Thaliees. All rights reserved.
//

import Foundation

// Define the following protocol
public protocol SecureStoreQueryable {
    var query: [String: Any] { get }
}

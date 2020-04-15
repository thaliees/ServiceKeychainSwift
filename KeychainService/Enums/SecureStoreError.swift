//
//  SecureStoreError.swift
//  KeychainService
//
//  Created by Thaliees on 1/20/20.
//  Copyright © 2020 Thaliees. All rights reserved.
//

import Foundation

public enum SecureStoreError: Error {
    case string2DataConversionError
    case data2StringConversionError
    case unexpectedItemData
    case unhandledError(message: String)
}

extension SecureStoreError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .string2DataConversionError:
            return "String to Data conversion error"
        case .data2StringConversionError:
            return "Data to String conversion error"
        case .unexpectedItemData:
            return "Unexpected Item Data"
        case .unhandledError(let message):
            return message
        }
    }
}


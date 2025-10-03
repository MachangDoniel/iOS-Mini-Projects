//
//  ErrorCase.swift
//  AyncAwaitSwiftUI
//
//  Created by Doniel Tripura on 10/3/25.
//

import Foundation

enum ErrorCase: LocalizedError {
    case invalidURL
    case invalidresponse
    case invalidData
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
            
        case .invalidresponse:
            return "Invalid Response"
            
        case .invalidData:
            return "Invalid Data"
        }
    }
}

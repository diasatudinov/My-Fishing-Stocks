//
//  MFFish.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFFish: Codable, Hashable, Identifiable {
    let id = UUID()
    var type: String
    var quantity: Int
    var age: FishAge
    var operations: [FishOperation]
    var note: String
    
    var imageData: Data?
    
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
    
}

struct FishOperation: Codable, Hashable, Identifiable {
    let id = UUID()
    var date: Date
    var status: OperationStatus
    var quantity: Int
}

enum OperationStatus: String, Codable, CaseIterable, Identifiable {
    case income
    case expense
     var id: String { rawValue }
    var text: String {
        switch self {
        case .income:
            "Income"
        case .expense:
            "Expense"
        }
    }
}
enum FishAge: String, Codable, CaseIterable, Identifiable {
    case young
    case fattening
    case commercial
    
    var id: String { rawValue }
    
    var text: String {
        switch self {
        case .young:
            "Young"
        case .fattening:
            "Fattening"
        case .commercial:
            "Commercial"
        }
    }
}

//
//  MFEquipment.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFEquipment: Codable, Hashable, Identifiable {
    let id = UUID()
    var name: String
    var type: EquipmentType
    var status: EquipmentStatus
    var frequency: Int
    var operations: [EquipmentOperation]
    var note: String
    var date: Date
    
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

struct EquipmentOperation: Codable, Hashable, Identifiable {
    let id = UUID()
    var date: Date
    var work: String
}


enum EquipmentType: String, Codable, CaseIterable, Identifiable {
    case pump
    case aerator
    case filter
    case other
    
    var id: String { rawValue }
    
    var text: String {
        switch self {
        case .pump:
            "Pump"
        case .aerator:
            "Aerator"
        case .filter:
            "Filter"
        case .other:
            "Other"
        }
    }
}

enum EquipmentStatus: String, Codable, CaseIterable, Identifiable {
    case use
    case repeir
    
    var id: String { rawValue }
    
    var text: String {
        switch self {
        case .use:
            "In use"
        case .repeir:
            "Under repeir"
        }
    }
    
    var color: Color {
        switch self {
        case .use:
                .green
        case .repeir:
                .red
        }
    }
}

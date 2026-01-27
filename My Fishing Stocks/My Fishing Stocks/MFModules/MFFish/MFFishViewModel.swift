//
//  MFFishViewModel.swift
//  My Fishing Stocks
//
//

import SwiftUI

final class MFFishViewModel: ObservableObject {
    @Published var fishes: [MFFish] = [
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
        MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil),
    ] {
        didSet {
           // saveProjects()
        }
    }
    
    init() {
        loadProjects()
    }
    
    private let userDefaultsProjectsKey = "fishKeyTest"
    
    // MARK: INCOMES
    
    func saveProjects() {
        if let encodedData = try? JSONEncoder().encode(fishes) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsProjectsKey)
        }
        
    }
    
    func loadProjects() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsProjectsKey),
           let loadedItem = try? JSONDecoder().decode([MFFish].self, from: savedData) {
            fishes = loadedItem
        } else {
            print("No saved data found: projects")
        }
    }
    
    
    func add(_ fish: MFFish) {
        fishes.append(fish)
    }
    
    
    func delete(fish: MFFish) {
        guard let index = fishes.firstIndex(where: { $0.id == fish.id }) else { return }
        fishes.remove(at: index)
    }
    
    func addOperation(fish: MFFish, operation: FishOperation) {
        guard let index = fishes.firstIndex(where: { $0.id == fish.id }) else { return }
        fishes[index].operations.append(operation)
    }
    
    func minusOperation(fish: MFFish, quantity: Int) {
        guard let index = fishes.firstIndex(where: { $0.id == fish.id }) else { return }
        fishes[index].quantity -= quantity
    }
    
    func plusOperation(fish: MFFish, quantity: Int) {
        guard let index = fishes.firstIndex(where: { $0.id == fish.id }) else { return }
        fishes[index].quantity += quantity
    }
}

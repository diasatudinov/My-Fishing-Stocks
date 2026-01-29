//
//  MFFishViewModel.swift
//  My Fishing Stocks
//
//

import SwiftUI

final class MFFishViewModel: ObservableObject {
    @Published var fishes: [MFFish] = [
    ] {
        didSet {
            saveProjects()
        }
    }
    
    @Published var equipments: [MFEquipment] = [
        MFEquipment(name: "Grundfos pump", type: .aerator, status: .use, frequency: 2, operations: [], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now),
        MFEquipment(name: "Grundfos pump", type: .aerator, status: .use, frequency: 2, operations: [], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now),
        MFEquipment(name: "Grundfos pump", type: .aerator, status: .use, frequency: 2, operations: [], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now),
        MFEquipment(name: "Grundfos pump", type: .aerator, status: .use, frequency: 2, operations: [], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now),
        MFEquipment(name: "Grundfos pump", type: .aerator, status: .use, frequency: 2, operations: [], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now),
    ] {
        didSet {
            saveEquipmets()
        }
    }
    
    init() {
        loadProjects()
        loadEquipmets()
    }
    
    private let userDefaultsProjectsKey = "fishKeyTest"
    private let userDefaultsEquipmentKey = "equipmentKeyTest"
    // MARK: MFFish
    
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
    
    // MARK: MFEquipments
    
    func saveEquipmets() {
        if let encodedData = try? JSONEncoder().encode(equipments) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsEquipmentKey)
        }
        
    }
    
    func loadEquipmets() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsEquipmentKey),
           let loadedItem = try? JSONDecoder().decode([MFEquipment].self, from: savedData) {
            equipments = loadedItem
        } else {
            print("No saved data found: projects")
        }
    }
    
    // MARK: MFFish

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
    
    // MARK: MFEquipments

    func add(_ equipment: MFEquipment) {
        equipments.append(equipment)
    }
    
    func delete(equipment: MFEquipment) {
        guard let index = equipments.firstIndex(where: { $0.id == equipment.id }) else { return }
        equipments.remove(at: index)
    }
    
    func addOperation(equipment: MFEquipment, operation: EquipmentOperation) {
        guard let index = equipments.firstIndex(where: { $0.id == equipment.id }) else { return }
        equipments[index].operations.append(operation)
    }
}

extension MFFishViewModel {

    /// Net change across ALL fish operations (Income - Expense)
    var overallNetChange: Int {
        fishes
            .flatMap(\.operations)
            .reduce(0) { result, op in
                result + (op.status == .income ? op.quantity : .zero)
            }
    }

    /// "Overall increase: +12" / "Overall decrease: 7" / "Overall change: 0"
    func overallIncreaseString() -> String {
        let net = overallNetChange

        if net > 0 {
            return "+\(net)"
        } else if net < 0 {
            return "\(abs(net))"
        } else {
            return "0"
        }
    }

    /// If you only want the value part: "+12" / "-7" / "0"
    func overallIncreaseValueString() -> String {
        let net = overallNetChange
        if net > 0 { return "+\(net)" }
        if net < 0 { return "\(net)" } // already negative
        return "0"
    }
}

extension MFFishViewModel {

    /// Sum of expense quantities (returned as a NEGATIVE number)
    private func departureTotal(in interval: DateInterval?) -> Int {
        let expenses = fishes
            .flatMap(\.operations)
            .filter { $0.status == .expense }

        let filtered: [FishOperation]
        if let interval {
            filtered = expenses.filter { interval.contains($0.date) }
        } else {
            filtered = expenses
        }

        let sum = filtered.reduce(0) { $0 + max(0, $1.quantity) }
        return -sum
    }

    private func startOfWeek(for date: Date, calendar: Calendar) -> Date {
        let comps = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: comps) ?? date
    }

    private func lastMonthInterval(for now: Date, calendar: Calendar) -> DateInterval? {
        guard let thisMonthStart = calendar.dateInterval(of: .month, for: now)?.start,
              let lastMonthDate = calendar.date(byAdding: .month, value: -1, to: thisMonthStart),
              let lastMonth = calendar.dateInterval(of: .month, for: lastMonthDate)
        else { return nil }
        return lastMonth
    }

    private func thisWeekInterval(for now: Date, calendar: Calendar) -> DateInterval {
        let start = startOfWeek(for: now, calendar: calendar)
        return DateInterval(start: start, end: now)
    }

    /// ["-50", "-30 Last Month", "-10 This Week"]
    func departureStrings(now: Date = .now, calendar: Calendar = .current) -> [String] {
        let all = departureTotal(in: nil)
        let lastMonth = departureTotal(in: lastMonthInterval(for: now, calendar: calendar))
        let thisWeek = departureTotal(in: thisWeekInterval(for: now, calendar: calendar))

        return [
            "\(all)",
            "\(lastMonth) Last Month",
            "\(thisWeek) This Week"
        ]
    }
}

extension MFFishViewModel {

    /// Total fish count right now (sum of all fish quantities)
    var currentPopulation: Int {
        fishes.reduce(0) { $0 + $1.quantity }
    }

    /// Net change (Income - Expense) within last N days
    func netChange(lastDays: Int, now: Date = .now, calendar: Calendar = .current) -> Int {
        guard let start = calendar.date(byAdding: .day, value: -lastDays, to: now) else { return 0 }
        let interval = DateInterval(start: start, end: now)

        return fishes
            .flatMap(\.operations)
            .filter { interval.contains($0.date) }
            .reduce(0) { result, op in
                result + (op.status == .income ? op.quantity : -op.quantity)
            }
    }

    /// Percent change for last 30 days относительно популяции 30 дней назад.
    /// Returns nil if baseline is 0 (can't compute meaningful percent).
    func last30DaysChangePercent(now: Date = .now, calendar: Calendar = .current) -> Double? {
        let net30 = netChange(lastDays: 30, now: now, calendar: calendar)
        let current = currentPopulation
        let baseline = current - net30   // population ~30 days ago

        guard baseline > 0 else { return nil }
        return (Double(net30) / Double(baseline)) * 100.0
    }

    /// Strings you can show in UI
    /// Example:
    /// "Current population: 1200"
    /// "Last 30 days: +3.4%"
    func currentPopulationAndLast30DaysPercentStrings(
        now: Date = .now,
        calendar: Calendar = .current,
        decimals: Int = 1
    ) -> (current: String, last30Days: String) {

        let current = currentPopulation
        let currentString = "\(current)"

        guard let pct = last30DaysChangePercent(now: now, calendar: calendar) else {
            return (currentString, "Last 30 days: —")
        }

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = decimals
        formatter.maximumFractionDigits = decimals

        let pctAbs = abs(pct)
        let pctText = formatter.string(from: NSNumber(value: pctAbs)) ?? String(format: "%.\(decimals)f", pctAbs)
        let sign = pct > 0 ? "+" : (pct < 0 ? "-" : "")

        return (currentString, "Last 30 days: \(sign)\(pctText)%")
    }
}

extension MFFishViewModel {

    func last30DaysPercentParts(
        now: Date = .now,
        calendar: Calendar = .current,
        decimals: Int = 1
    ) -> (label: String, percent: String, percentColor: Color) {

        guard let pct = last30DaysChangePercent(now: now, calendar: calendar) else {
            return ("Last 30 days: ", "—", .secondary)
        }

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = decimals
        formatter.maximumFractionDigits = decimals

        let absText = formatter.string(from: NSNumber(value: abs(pct)))
            ?? String(format: "%.\(decimals)f", abs(pct))

        let sign = pct > 0 ? "+" : (pct < 0 ? "-" : "")
        let percentString = "\(sign)\(absText)%"

        let color: Color = pct > 0 ? .green : (pct < 0 ? .red : .secondary)
        return ("Last 30 days: ", percentString, color)
    }
}

import SwiftUI
import Charts

struct FishPopulationChange: Identifiable {
    let id = UUID()
    let date: Date
    let delta: Int   // +income, -expense
}

struct FishLast7ChangesChartView: View {
    let fish: MFFish

    private var last7: [FishPopulationChange] {
        fish.operations
            .sorted { $0.date < $1.date }
            .suffix(7)
            .map { op in
                let delta = (op.status == .income) ? op.quantity : -op.quantity
                return FishPopulationChange(date: op.date, delta: delta)
            }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Последние 7 изменений популяции")
                .font(.headline)

            Chart(last7) { item in
                BarMark(
                    x: .value("Дата", item.date),
                    y: .value("Изменение", item.delta)
                )
                // Цвет для +/-
                .foregroundStyle(item.delta >= 0 ? .green : .red)
                .cornerRadius(4)
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 7)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.day().month(), centered: true)
                }
            }
            .chartYAxis {
                AxisMarks { _ in
                    AxisGridLine()
                    AxisValueLabel()
                }
            }
            .frame(height: 240)
        }
        .padding()
    }
}
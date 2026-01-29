//
//  FishPopulationChange.swift
//  My Fishing Stocks
//
//


import SwiftUI
import Charts

struct TotalStepPoint: Identifiable {
    let id = UUID()
    let step: Int   // 1...9
    let total: Int  // общее количество
}
//     Dynamics of fish population
struct FarmTotalLast9StepsChartView: View {
    @ObservedObject var vm: MFFishViewModel

    private var totalNow: Int {
        vm.fishes.reduce(0) { $0 + $1.quantity }
    }

    private var last9TotalsByStep: [TotalStepPoint] {
        let ops = vm.fishes.flatMap { $0.operations }   // все операции всех рыб
        guard !ops.isEmpty else { return [] }

        func delta(_ op: FishOperation) -> Int {
            op.status == .income ? op.quantity : -op.quantity
        }

        // Восстанавливаем total до первой операции:
        // totalNow = totalBeforeFirst + sum(deltas)
        let sumDeltas = ops.reduce(0) { $0 + delta($1) }
        var runningTotal = totalNow - sumDeltas

        var totals: [Int] = []
        totals.reserveCapacity(ops.count)

        for op in ops {
            runningTotal += delta(op)
            totals.append(max(0, runningTotal))
        }

        let last = Array(totals.suffix(9))
        return last.enumerated().map { idx, total in
            TotalStepPoint(step: idx + 1, total: total) // 1..9
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Dynamics of fish population")
                .font(.system(size: 14, weight: .light))
                .textCase(.uppercase)
            
            if last9TotalsByStep.isEmpty {
                Text("There are no operations to plot the graph.")
                    .foregroundStyle(.secondary)
            } else {
                Chart(last9TotalsByStep) { item in
                    BarMark(
                        x: .value("step", item.step),
                        y: .value("Total", item.total),
                        width: .fixed(20)
                    )
                    .foregroundStyle(.appPurple)
                }
                .chartXAxis {
                    AxisMarks(values: last9TotalsByStep.map(\.step)) { value in
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { _ in   
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .chartYScale(domain: 0...max(1, last9TotalsByStep.map(\.total).max() ?? 1))
                .frame(height: 260)
                
            }
        }
        .padding(.horizontal).padding(.bottom)
    }
}

#Preview {
    MFStatisticsView(viewModel: MFFishViewModel())
}

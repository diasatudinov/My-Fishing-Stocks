//
//  MFStatisticsView.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFStatisticsView: View {
    @ObservedObject var viewModel: MFFishViewModel
    
    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "Statistics"
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 11) {
                    FarmTotalLast9StepsChartView(vm: viewModel)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(alignment: .leading) {
                        Text("Overall increase")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(viewModel.overallIncreaseString())
                            .font(.system(size: 40, weight: .bold))
                    }
                    .padding(24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(alignment: .leading) {
                        let lines = viewModel.departureStrings()
                        Text("Departure")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(lines[0])
                            .font(.system(size: 40, weight: .bold))
                        
                        Text(lines[1])
                            .font(.system(size: 14, weight: .regular))
                        
                        Text(lines[2])
                            .font(.system(size: 14, weight: .regular))
                    }
                    .padding(24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        let strings = viewModel.currentPopulationAndLast30DaysPercentStrings()
                        
                        Text("Current population")
                            .font(.system(size: 14, weight: .light))
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(strings.current)
                            .font(.system(size: 40, weight: .bold))
                        
                        let parts = viewModel.last30DaysPercentParts()

                        HStack {
                            Text(parts.label)
                            
                            Text(parts.percent)
                                .foregroundColor(parts.percentColor)
                                .padding(8)
                                .background(parts.percentColor.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .font(.system(size: 14, weight: .regular))
                        
                        
                    }
                    .padding(24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 13)
                .padding(.top)
                .padding(.bottom, 150)
                
            }
        }
        .background(
            Image(.appBgMF)
                .resizable()
                .scaledToFill()
        )
    }
}


#Preview {
    MFStatisticsView(viewModel: MFFishViewModel())
}

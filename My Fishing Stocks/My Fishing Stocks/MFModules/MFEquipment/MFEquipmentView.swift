//
//  MFEquipmentView.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFEquipmentView: View {
    @ObservedObject var viewModel: MFFishViewModel

    private let columns = [
           GridItem(.flexible(), spacing: 12),
           GridItem(.flexible(), spacing: 12)
       ]
    
    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "Equipment"
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.equipments, id: \.id) { equipment in
                            NavigationLink {
                                MFEquipmentDetailsView(viewModel: viewModel, equipment: equipment)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                MFEquipmentCellView(equipment: equipment)
                            }
                        }
                    }.padding(.horizontal)
                    
                }
                .padding(.top)
                .padding(.bottom, 150)
                
            }.overlay(alignment: .bottomTrailing) {
                NavigationLink {
                    MFNewEquipment(viewModel: viewModel)
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Add Equipment")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                        .padding(.vertical, 7).padding(.horizontal, 66)
                        .background(Gradients.buttonAdd.color)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                .padding()
                .padding(.bottom, 80)
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
    NavigationStack {
        MFEquipmentView(viewModel: MFFishViewModel())
    }
}

//
//  MFFishView.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFFishView: View {
    @ObservedObject var viewModel: MFFishViewModel

    private let columns = [
           GridItem(.flexible(), spacing: 12),
           GridItem(.flexible(), spacing: 12)
       ]
    
    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "Main"
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(.fishIconMF)
                        .resizable()
                        .scaledToFit()
                        .padding(.top)
                        .padding(.horizontal, 50)
                    
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.fishes, id: \.id) { fish in
                            NavigationLink {
                                MFFishDetailsView(viewModel: viewModel, fish: fish)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                MFFishCellView(fish: fish)
                            }
                        }
                    }.padding(.horizontal)
                    
                }
                
                .padding(.bottom, 150)
                
            }.overlay(alignment: .bottomTrailing) {
                NavigationLink {
                    MFNewFish(viewModel: viewModel)
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Add Fish")
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
        MFFishView(viewModel: MFFishViewModel())
    }
}

//
//  MFFishDetailsView.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFFishDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MFFishViewModel

    let fish: MFFish

    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "\(fish.type)",
                leading: .init(systemImage: "arrow.left", action: { dismiss() }),
                trailing: .init(systemImage: "trash", action: { viewModel.delete(fish: fish); dismiss() })
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    
                    VStack(spacing: 8) {
                        if let image = fish.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 135)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay {
                                    Text("Change image")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundStyle(.white)
                                }
                        } else {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.imageShimmer)
                                .frame(width: 300, height: 135)
                                .overlay {
                                    Text("upload image...")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundStyle(.imageShimmerText)
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(lineWidth: 1)
                                        .foregroundStyle(.imageShimmer)
                                }
                        }
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text(fish.type)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(fish.quantity)pcs")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                
                            }
                            
                            Text(fish.note)
                                .font(.system(size: 11, weight: .regular))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.white)
                                )
                                .scrollContentBackground(.hidden)
                                
                            
                        }
                        
                    }
                    .padding(12)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 34)
                    .padding(.bottom)
                    
                    VStack {
                        ForEach(fish.operations, id: \.id) { operation in
                            operationCell(operation: operation)
                        }
                            
                    }.padding(.horizontal)
                }
                .padding()
            }
            .overlay(alignment: .bottomTrailing) {
                NavigationLink {
                    MFNewOperationView(viewModel: viewModel, fish: fish)
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                        .padding(25)
                        .background(Gradients.buttonAdd.color)
                        .clipShape(Circle())
                }
                .padding(.trailing, 40)
                .padding(.bottom, 80)
            }
        }
        .background(
            Image(.appBgMF)
                .resizable()
                .scaledToFill()
        )
    }
    
    @ViewBuilder func operationCell(
        operation: FishOperation
    ) -> some View {
        HStack(spacing: 8)  {
            Text("\(dateFormatter(operation.date))")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.newPurple)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\(operation.status == .income ? "+":"-") \(operation.quantity)")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.newPurple)
        }
        .padding(.vertical, 16).padding(.horizontal, 21)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 2)
                .foregroundStyle(.textFieldSecondary)
        }
    }
    
    func dateFormatter(_ date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0) // or .current
        df.dateFormat = "dd.MM.yyyy"
        return df.string(from: date)
    }
}

#Preview {
    MFFishDetailsView(viewModel: MFFishViewModel(), fish: MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [FishOperation(date: .now, status: .expense, quantity: 200), FishOperation(date: .now, status: .income, quantity: 400)], note: "For fattasdas", imageData: nil))
}

//
//  MFNewOperationView.swift
//  My Fishing Stocks
//
//  Created by Dias Atudinov on 29.01.2026.
//


import SwiftUI

struct MFEquipmenNewOperationView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MFFishViewModel

    let fish: MFFish

    @State private var date: Date = Date.now
    @State private var quantity: String = ""
    @State private var status: OperationStatus = .income

    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "\(fish.type)",
                leading: .init(systemImage: "arrow.left", action: { dismiss() })
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    
                    VStack(spacing: 8) {
                        textFiled(title: "Date") {
                                
                                HStack(alignment: .bottom) {
                                    DatePicker(
                                        "",
                                        selection: $date,
                                        displayedComponents: .date
                                    ).labelsHidden()
                                    
                                    Spacer()
                                    
                                }
                            
                        }
                        
                        textFiled(title: "Age") {
                            Menu {
                                ForEach(OperationStatus.allCases) { status in
                                    Button {
                                        self.status = status
                                    } label: {
                                        if status == self.status {
                                            Label(status.text, systemImage: "checkmark")
                                        } else {
                                            Text(status.text)
                                            
                                        }
                                    }
                                }
                            } label: {
                                HStack(spacing: 8) {
                                    Text(self.status.text)
                                        .font(.system(size: 20, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 7)
                                }
                                .foregroundStyle(.black)
                                .padding(.vertical, 13).padding(.horizontal, 16)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                        
                        textFiled(title: "Quantity") {
                            TextField("Quantity", text: $quantity)
                                .font(.system(size: 20, weight: .semibold))
                                .keyboardType(.numberPad)
                                .padding(.vertical, 11).padding(.horizontal, 16)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(alignment: .trailing) {
                                    Image(systemName: "pencil")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 20)
                                        .bold()
                                        .foregroundStyle(.textFieldSecondary)
                                        .padding()
                                }
                        }
                        
                        
                        
                        Button {
                           
                            let operation = FishOperation(date: date, status: status, quantity: Int(quantity) ?? 0)
                            viewModel.addOperation(fish: fish, operation: operation)
                            if status == .income {
                                viewModel.plusOperation(fish: fish, quantity: Int(quantity) ?? 0)
                            } else {
                                viewModel.minusOperation(fish: fish, quantity: Int(quantity) ?? 0)
                            }
                            dismiss()
                        } label: {
                            Text("Add")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.black)
                                .padding(.vertical, 7).padding(.horizontal, 66)
                                .background(Gradients.buttonAdd.color)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                        }.padding(.top, 24)
                    }.padding(.horizontal, 14)
                    
                }
                .padding()
                .padding(.bottom, 150)
            }
        }
        .background(
            Image(.appBgMF)
                .resizable()
                .scaledToFill()
        )

    }
    
    @ViewBuilder func textFiled<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 8)  {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.newPurple)
            
            content()
        }
    }
}

#Preview {
    MFNewOperationView(viewModel: MFFishViewModel(), fish: MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [FishOperation(date: .now, status: .expense, quantity: 200), FishOperation(date: .now, status: .income, quantity: 400)], note: "For fattasdas", imageData: nil))
}

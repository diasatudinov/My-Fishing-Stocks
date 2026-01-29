//
//  MFNewOperationView.swift
//  My Fishing Stocks
//
//


import SwiftUI

struct MFEquipmentNewOperationView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MFFishViewModel

    let equipment: MFEquipment

    @State private var date: Date = Date.now
    @State private var work: String = ""

    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "\(equipment.name)",
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
                        
                        textFiled(title: "Type of work") {
                            TextField("Type of work", text: $work)
                                .font(.system(size: 20, weight: .semibold))
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
                           
                            let operation = EquipmentOperation(date: date, work: work)
                            viewModel.addOperation(equipment: equipment, operation: operation)
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
    MFEquipmentNewOperationView(viewModel: MFFishViewModel(), equipment: MFEquipment(name: "Grundfos pump", type: .aerator, status: .use, frequency: 2, operations: [], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now))
}

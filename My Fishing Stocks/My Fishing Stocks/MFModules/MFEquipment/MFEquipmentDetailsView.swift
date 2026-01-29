//
//  MFEquipmentDetailsView.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFEquipmentDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MFFishViewModel

    let equipment: MFEquipment

    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "\(equipment.name)",
                leading: .init(systemImage: "arrow.left", action: { dismiss() }),
                trailing: .init(systemImage: "trash", action: { viewModel.delete(equipment: equipment); dismiss() })
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    
                    VStack(spacing: 8) {
                        if let image = equipment.image {
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
                                Text(equipment.name)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(equipment.status.text)")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                
                            }
                            
                            Text(equipment.note)
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
                        ForEach(equipment.operations, id: \.id) { operation in
                            operationCell(operation: operation)
                        }
                            
                    }.padding(.horizontal)
                }
                .padding()
            }
            .overlay(alignment: .bottomTrailing) {
                NavigationLink {
                    MFEquipmentNewOperationView(viewModel: viewModel, equipment: equipment)
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
        operation: EquipmentOperation
    ) -> some View {
        textFiled(title: "\(dateFormatter(operation.date))") {
            HStack(spacing: 8) {
                Text(operation.work)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .bold()
                    .foregroundStyle(.textFieldSecondary)
            }
            .foregroundStyle(.black)
            .padding(.vertical, 13).padding(.horizontal, 16)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.textFieldSecondary)
            }

        }
    }
    
    func dateFormatter(_ date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0) // or .current
        df.dateFormat = "dd.MM.yyyy"
        return df.string(from: date)
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
    MFEquipmentDetailsView(viewModel: MFFishViewModel(), equipment: MFEquipment(name: "Grundfos pump", type: .aerator, status: .repeir, frequency: 2, operations: [EquipmentOperation(date: .now, work: "Maintenance")], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now)
)
}

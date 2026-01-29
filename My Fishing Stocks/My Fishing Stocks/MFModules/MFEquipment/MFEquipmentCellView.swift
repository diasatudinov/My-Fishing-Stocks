//
//  MFEquipmentCellView.swift
//  My Fishing Stocks
//
//


import SwiftUI

struct MFEquipmentCellView: View {
    let equipment: MFEquipment
    var body: some View {
        VStack(spacing: 8) {
            if let image = equipment.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .overlay {
                        Text("Change image")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.white)
                    }
            } else {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.imageShimmer)
                    .frame(width: 150, height: 90)
                    .overlay {
                        Text("upload image...")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(.imageShimmerText)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.imageShimmer)
                    }
            }
            
            VStack(spacing: 12) {
                Text(equipment.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text("\(equipment.status.text)")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(equipment.status.color)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
        }
        .frame(width: 150)
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MFEquipmentCellView(equipment: MFEquipment(name: "Grundfos pump", type: .aerator, status: .repeir, frequency: 2, operations: [], note: "Nominal flow rate: 4.58 m³/h\nNominal head: 4.8 m", date: .now)
    )
}

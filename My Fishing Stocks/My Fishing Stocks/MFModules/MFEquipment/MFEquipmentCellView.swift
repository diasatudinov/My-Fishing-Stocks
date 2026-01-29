//
//  MFFishCellView.swift
//  My Fishing Stocks
//
//  Created by Dias Atudinov on 29.01.2026.
//


import SwiftUI

struct MFFishCellView: View {
    let fish: MFFish
    var body: some View {
        VStack(spacing: 8) {
            if let image = fish.image {
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
                HStack(spacing: 20) {
                    Text(fish.type)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(fish.quantity)pcs")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.black)
                    
                }
                
                Text(fish.age.text)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(.black)
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
    MFFishCellView(fish: MFFish(type: "Corp", quantity: 1200, age: .fattening, operations: [], note: "For fattening", imageData: nil))
}

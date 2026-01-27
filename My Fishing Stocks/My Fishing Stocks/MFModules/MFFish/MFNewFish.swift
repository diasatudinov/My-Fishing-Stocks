//
//  MFNewFish.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct MFNewFish: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MFFishViewModel
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false

    @State private var title: String = ""
    @State private var quantity: String = ""
    @State private var note = ""
    @State private var age: FishAge = .young

    var body: some View {
        ScreenContainer(
            topBar: .init(
                title: "New Fish",
                leading: .init(systemImage: "arrow.left", action: { dismiss() })
            )
        ) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    
                    VStack(spacing: 8) {
                        if let image = selectedImage {
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
                                .onTapGesture {
                                    withAnimation {
                                        showingImagePicker = true
                                    }
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
                                .onTapGesture {
                                    withAnimation {
                                        showingImagePicker = true
                                    }
                                }
                        }
                        
                        VStack {
                            HStack {
                                Text(title)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(quantity)pcs")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(.black)
                                
                            }
                            
                            TextEditor(text: $note)
                                .font(.system(size: 11, weight: .regular))
                                .frame(height: 50)
                                .foregroundStyle(.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.white)
                                )
                                .scrollContentBackground(.hidden)
                                .overlay(alignment: .topLeading) {
                                    if note.isEmpty {
                                        Text("Note")
                                            .font(.system(size: 11, weight: .regular))
                                            .foregroundStyle(.secondary)
                                            .allowsHitTesting(false)
                                            .padding(.top, 10)
                                            .padding(.leading, 4)
                                    }
                                }
                            
                        }
                        
                    }
                    .padding(12)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 34)
                    
                    VStack(spacing: 8) {
                        textFiled(title: "Type") {
                            TextField("Type", text: $title)
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
                        
                        textFiled(title: "Age") {
                            Menu {
                                ForEach(FishAge.allCases) { age in
                                    Button {
                                        self.age = age
                                    } label: {
                                        if age == self.age {
                                            Label(age.text, systemImage: "checkmark")
                                        } else {
                                            Text(age.text)
                                            
                                        }
                                    }
                                }
                                
                            } label: {
                                HStack(spacing: 8) {
                                    Text(self.age.text)
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
                        
                        Button {
                            let fish = MFFish(type: title, quantity: Int(quantity) ?? 0, age: age, operations: [], note: note, imageData: selectedImage?.jpegData(compressionQuality: 0.7))
                            viewModel.add(fish)
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
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $showingImagePicker)
        }
        .background(
            Image(.appBgMF)
                .resizable()
                .scaledToFill()
        )
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
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
    MFNewFish(viewModel: MFFishViewModel())
}

//
//  MFMenuView.swift
//  My Fishing Stocks
//
//

import SwiftUI

struct VQMenuContainer: View {
    @AppStorage("firstOpenPC") var firstOpen: Bool = true
    var body: some View {
        NavigationStack {
            ZStack {
                VQMenuView()
            }
        }
    }
}

struct VQMenuView: View {
    @State var selectedTab = 0
    @StateObject var viewModel = MFFishViewModel()
    private let tabs = ["", "",""]
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                MFStatisticsView(viewModel: viewModel)
            case 1:
                MFFishView(viewModel: viewModel)
            case 2:
                MFEquipmentView(viewModel: viewModel)
            default:
                Text("default")
            }
            
            VStack {
                Spacer()
                
                HStack {
                    ForEach(0..<tabs.count) { index in
                        Button(action: {
                            selectedTab = index
                        }) {
                            VStack(spacing: 2) {
                                Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20)
                                
                                Text(text(for: index))
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundStyle(selectedTab == index ? .white: .appPurple)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 4).padding(.vertical, 11)
                            .background(selectedTab == index ?  Gradients.tabBar.color : Gradients.clear.color)
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                            
                        }
                    }
                }
                .padding(.horizontal, 4).padding(.vertical, 4)
                .background(.white.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .padding(.horizontal, 34)
            }
            .padding(.bottom, 24)
            .ignoresSafeArea()
            
            
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconMF"
        case 1: return "tab2IconMF"
        case 2: return "tab3IconMF"
        default: return ""
        }
    }
    
    private func selectedIcon(for index: Int) -> String {
        switch index {
        case 0: return "tab1IconSelectedMF"
        case 1: return "tab2IconSelectedMF"
        case 2: return "tab3IconSelectedMF"
        default: return ""
        }
    }
    
    private func text(for index: Int) -> String {
        switch index {
        case 0: return "Statistics"
        case 1: return "Fish"
        case 2: return "Equipment"
        default: return ""
        }
    }
}

#Preview {
    VQMenuContainer()
}

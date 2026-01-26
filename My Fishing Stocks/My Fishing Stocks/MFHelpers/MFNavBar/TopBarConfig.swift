import SwiftUI

struct TopBarConfig {
    var title: String
    var subtitle: String? = nil

    var leading: BarItem? = nil
    var trailing: [BarItem] = []

    struct BarItem: Identifiable {
        let id = UUID()
        var systemImage: String
        var action: () -> Void
        var accessibilityLabel: String? = nil
    }
}

struct GradientTopBar: View {
    let config: TopBarConfig

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple.opacity(0.9), Color.blue.opacity(0.9)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: .top)

            HStack(spacing: 12) {
                if let leading = config.leading {
                    barButton(leading)
                } else {
                    // чтобы заголовок не "прыгал" между экранами
                    Color.clear.frame(width: 44, height: 44)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(config.title)
                        .font(.headline)
                        .foregroundColor(.white)

                    if let subtitle = config.subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                    }
                }

                Spacer()

                ForEach(config.trailing) { item in
                    barButton(item)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 10)
        }
        .frame(height: 110) // под себя
    }

    @ViewBuilder
    private func barButton(_ item: TopBarConfig.BarItem) -> some View {
        Button(action: item.action) {
            Image(systemName: item.systemImage)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color.white.opacity(0.18))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .accessibilityLabel(item.accessibilityLabel ?? "")
    }
}

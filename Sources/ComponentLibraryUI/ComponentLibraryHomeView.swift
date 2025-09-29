import SwiftUI

struct ComponentCategory: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let description: String
    let color: Color
}

struct FeaturedComponent: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let colors: [Color]
    let badge: String

    var gradient: LinearGradient {
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    var primaryColor: Color {
        colors.first ?? .blue
    }
}

struct ComponentLibraryHomeView: View {
    private let categories: [ComponentCategory] = [
        ComponentCategory(
            title: "按钮",
            icon: "square.grid.2x2.fill",
            description: "快速访问常用按钮样式",
            color: Color.blue.opacity(0.2)
        ),
        ComponentCategory(
            title: "卡片",
            icon: "rectangle.on.rectangle.angled",
            description: "展示内容信息的精美卡片",
            color: Color.purple.opacity(0.2)
        ),
        ComponentCategory(
            title: "输入",
            icon: "pencil.and.outline",
            description: "表单与输入相关的控件",
            color: Color.orange.opacity(0.2)
        ),
        ComponentCategory(
            title: "导航",
            icon: "point.topleft.down.curvedto.point.bottomright.up",
            description: "多种导航交互形式",
            color: Color.green.opacity(0.2)
        )
    ]

    private let featured: [FeaturedComponent] = [
        FeaturedComponent(
            title: "全新按钮组",
            subtitle: "12种按钮样式，满足你所有的设计需求",
            colors: [.blue, .purple],
            badge: "NEW"
        ),
        FeaturedComponent(
            title: "玻璃拟态卡片",
            subtitle: "高斯模糊 + 自适应阴影，让界面更具层次",
            colors: [.pink, .orange],
            badge: "TREND"
        )
    ]

    private let trends: [String] = [
        "渐变风格",
        "暗色模式适配",
        "动态岛组件",
        "Vision Pro 交互"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection
                    searchSection
                    featuredSection
                    categorySection
                    trendSection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI 组件库")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)

                    Text("探索精心设计的组件，一键复制到你的项目")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "sparkles")
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            }

            HStack(spacing: 12) {
                Label("收藏夹", systemImage: "heart.fill")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.pink, in: Capsule())

                Label("最近更新", systemImage: "clock.fill")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.indigo, in: Capsule())

                Spacer()
            }
        }
    }

    private var searchSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("搜索组件")
                .font(.headline)
                .foregroundColor(.primary)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                Text("输入组件名称、关键字…")
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.blue)
                    .padding(6)
                    .background(Color.blue.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 6)
        }
    }

    private var featuredSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(title: "精选组件", subtitle: "本周人气最高的组件")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(featured) { component in
                        featuredCard(component)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(title: "组件分类", subtitle: "根据类型快速定位")

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                ForEach(categories) { category in
                    categoryCard(category)
                }
            }
        }
    }

    private var trendSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader(title: "设计趋势", subtitle: "紧跟设计潮流与最佳实践")

            VStack(spacing: 12) {
                ForEach(trends.indices, id: \.self) { index in
                    HStack(alignment: .center, spacing: 12) {
                        Text(String(format: "%02d", index + 1))
                            .font(.headline.bold())
                            .foregroundColor(.blue)
                            .frame(width: 36, height: 36)
                            .background(Color.blue.opacity(0.12), in: RoundedRectangle(cornerRadius: 12, style: .continuous))

                        VStack(alignment: .leading, spacing: 4) {
                            Text(trends[index])
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("了解最新组件如何适配新平台与交互")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.tertiaryLabel))
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                    )
                }
            }
        }
    }

    private func sectionHeader(title: String, subtitle: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title3.bold())
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button(action: {}) {
                Label("查看全部", systemImage: "arrow.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.blue)
            }
        }
    }

    private func featuredCard(_ component: FeaturedComponent) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(component.badge)
                .font(.caption.weight(.heavy))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.white.opacity(0.2), in: Capsule())

            Spacer(minLength: 0)

            VStack(alignment: .leading, spacing: 6) {
                Text(component.title)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                Text(component.subtitle)
                    .font(.footnote)
                    .foregroundColor(Color.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
                .background(Color.white.opacity(0.3))

            HStack {
                Label("23 个样式", systemImage: "square.grid.3x3.fill")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.white.opacity(0.9))
            }
        }
        .padding(20)
        .frame(width: 260, height: 220)
        .background(component.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: component.primaryColor.opacity(0.35), radius: 20, x: 0, y: 16)
    }

    private func categoryCard(_ category: ComponentCategory) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: category.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .padding(12)
                .background(category.color, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            Text(category.title)
                .font(.headline)

            Text(category.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 0)

            HStack {
                Text("8 个组件")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.tertiaryLabel))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 180, alignment: .topLeading)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: Color.black.opacity(0.05), radius: 12, x: 0, y: 8)
    }
}

struct ComponentLibraryHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ComponentLibraryHomeView()
            ComponentLibraryHomeView()
                .preferredColorScheme(.dark)
        }
    }
}

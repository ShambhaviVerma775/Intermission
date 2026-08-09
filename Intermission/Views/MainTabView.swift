import SwiftUI

struct MainTabView: View {

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 13/255, green: 13/255, blue: 13/255, alpha: 1) // Midnight Black

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            WatchlistView()
                .tabItem {
                    Label("Watchlist", systemImage: "bookmark")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear.circle")
                }
        }
        .tint(Color(red: 215/255, green: 38/255, blue: 56/255)) // Cinema Red
    }
}

#Preview {
    MainTabView()
        .environmentObject(WatchlistManager())
}

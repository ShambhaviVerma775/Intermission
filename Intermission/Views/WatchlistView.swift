import SwiftUI

struct WatchlistView: View {
    var body: some View {
        NavigationStack {
            EmptyStateView(
                iconName: "bookmark",
                title: "Your Watchlist is Empty",
                message: "Movies and TV shows you add to your watchlist will appear here."
            )
            .navigationTitle("Watchlist")
        }
    }
}

#Preview {
    WatchlistView()
}

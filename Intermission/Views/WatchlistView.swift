import SwiftUI

struct WatchlistView: View {
    @EnvironmentObject var watchlistManager: WatchlistManager
    
    // Create a flexible grid layout with 2 columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            if watchlistManager.movies.isEmpty {
                EmptyStateView(
                    iconName: "bookmark",
                    title: "Your Watchlist is Empty",
                    message: "Movies and TV shows you add to your watchlist will appear here."
                )
                .navigationTitle("Watchlist")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(watchlistManager.movies) { movie in
                            NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                                MovieCard(movie: movie)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Watchlist")
            }
        }
    }
}

#Preview {
    WatchlistView()
        .environmentObject(WatchlistManager())
}

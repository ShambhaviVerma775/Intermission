import SwiftUI

struct WatchlistView: View {
    @EnvironmentObject var watchlistManager: WatchlistManager

    // MARK: - Theme
    private let backgroundColor = Color(red: 13/255, green: 13/255, blue: 13/255)
    private let cinemaRed = Color(red: 215/255, green: 38/255, blue: 56/255)

    // 2-column grid
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()

                if watchlistManager.movies.isEmpty {

                    EmptyStateView(
                        iconName: "bookmark",
                        title: "Your Watchlist is Empty",
                        message: "Movies and TV shows you add to your watchlist will appear here."
                    )

                } else {

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(watchlistManager.movies) { movie in
                                NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {

                                    MovieCard(movie: movie)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color(red: 26/255, green: 26/255, blue: 26/255).opacity(0.85))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.white.opacity(0.05), lineWidth: 1)
                                        )

                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Watchlist")
            .toolbarBackground(backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .tint(cinemaRed)
        }
    }
}

#Preview {
    WatchlistView()
        .environmentObject(WatchlistManager())
}

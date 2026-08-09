import SwiftUI

struct MovieListView: View {
    var title: String
    var movies: [Movie]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                        MovieCard(movie: movie)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(Color(red: 13/255, green: 13/255, blue: 13/255))
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(red: 13/255, green: 13/255, blue: 13/255), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .tint(Color(red: 215/255, green: 38/255, blue: 56/255))
    }
}

#Preview {
    NavigationStack {
        MovieListView(title: "Preview List", movies: [])
            .environmentObject(WatchlistManager())
    }
}

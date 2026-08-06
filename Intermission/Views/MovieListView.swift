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
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MovieListView(title: "Preview List", movies: [])
            .environmentObject(WatchlistManager())
    }
}

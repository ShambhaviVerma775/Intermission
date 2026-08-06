import SwiftUI

struct GenreMoviesView: View {
    var genre: Genre
    @StateObject private var viewModel = GenreMoviesViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                            MovieCard(movie: movie)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            }
            
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        viewModel.fetchMovies(for: genre.id)
                    }
                    .padding(.top, 8)
                }
            }
        }
        .navigationTitle(genre.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.fetchMovies(for: genre.id)
        }
    }
}

#Preview {
    NavigationStack {
        GenreMoviesView(genre: Genre(id: 28, name: "Action"))
            .environmentObject(WatchlistManager())
    }
}

import Foundation

@MainActor
class WatchlistManager: ObservableObject {
    @Published var movies: [Movie] = []
    
    /// Checks if a movie is already in the watchlist.
    func contains(_ movie: Movie) -> Bool {
        movies.contains(where: { $0.id == movie.id })
    }
    
    /// Adds or removes a movie from the watchlist.
    func toggle(_ movie: Movie) {
        if contains(movie) {
            movies.removeAll(where: { $0.id == movie.id })
        } else {
            movies.append(movie)
        }
    }
    
    /// Clears the entire watchlist.
    func clear() {
        movies.removeAll()
    }
}

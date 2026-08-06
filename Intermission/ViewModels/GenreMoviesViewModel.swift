import Foundation

@MainActor
class GenreMoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchMovies(for genreId: Int) {
        if !movies.isEmpty { return } // Prevent refetching
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                self.movies = try await APIService.shared.fetchMoviesByGenre(genreId: genreId)
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to load movies for this genre."
                self.isLoading = false
            }
        }
    }
}

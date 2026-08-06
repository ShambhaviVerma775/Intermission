import Foundation

@MainActor
class MovieDetailsViewModel: ObservableObject {
    @Published var movieDetails: Movie?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    /// Fetches extended details for a specific movie ID and updates the UI state.
    func fetchDetails(id: Int) {
        // Prevent duplicate fetches if we already have the details
        if movieDetails?.id == id && movieDetails?.runtime != nil { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                self.movieDetails = try await APIService.shared.fetchMovieDetails(id: id)
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to load movie details. Please try again."
                self.isLoading = false
            }
        }
    }
}

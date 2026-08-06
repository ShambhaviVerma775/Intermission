import Foundation

@MainActor // Ensures that all UI updates triggered by these @Published properties happen on the main thread
class HomeViewModel: ObservableObject {
    @Published var trendingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var genres: [Genre] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        // Data can be fetched here or explicitly when the view appears.
    }
    
    /// Fetches all required home screen data concurrently.
    func fetchHomeData() {
        // Prevent re-fetching if data is already loaded to save network requests
        if !trendingMovies.isEmpty { return }
        
        isLoading = true
        errorMessage = nil
        
        // Spin up a Task to perform async work in a synchronous context
        Task {
            do {
                // Using async let to fetch data concurrently
                async let trending = APIService.shared.fetchTrendingMovies()
                async let topRated = APIService.shared.fetchTopRatedMovies()
                async let popular = APIService.shared.fetchPopularMovies()
                async let fetchedGenres = APIService.shared.fetchGenres()
                
                // Await all concurrent tasks
                self.trendingMovies = try await trending
                self.topRatedMovies = try await topRated
                self.popularMovies = try await popular
                self.genres = try await fetchedGenres
                
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to load content. Please check your connection."
                self.isLoading = false
            }
        }
    }
}

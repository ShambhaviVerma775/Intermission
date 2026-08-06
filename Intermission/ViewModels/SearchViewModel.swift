import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResults: [Movie] = []
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() { }
    
    /// Performs a search request to the TMDB API using the current query.
    func performSearch() {
        guard !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                self.searchResults = try await APIService.shared.searchMovies(query: self.searchQuery)
                self.isLoading = false
            } catch {
                self.errorMessage = "Search failed. Please try again."
                self.isLoading = false
            }
        }
    }
}

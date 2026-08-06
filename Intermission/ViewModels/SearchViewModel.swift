import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResults: [String] = []
    
    init() {
        // Initialization for API calls can go here
    }
}

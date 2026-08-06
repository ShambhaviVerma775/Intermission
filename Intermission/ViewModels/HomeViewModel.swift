import Foundation

class HomeViewModel: ObservableObject {
    @Published var trendingMovies: [String] = ["Movie 1", "Movie 2", "Movie 3", "Movie 4"]
    @Published var topRatedMovies: [String] = ["Movie A", "Movie B", "Movie C", "Movie D"]
    @Published var browseByGenre: [String] = ["Action", "Comedy", "Drama", "Sci-Fi"]
    
    init() {
        // Initialization for API calls can go here
    }
}

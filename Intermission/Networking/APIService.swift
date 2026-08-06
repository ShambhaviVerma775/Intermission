import Foundation

/// A custom error enum to handle different networking failures gracefully.
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

/// The main networking service responsible for interacting with the TMDB API.
class APIService {
    // Shared singleton instance for easy access across the app.
    static let shared = APIService()
    private init() {}
    
    // MARK: - Helper Methods
    
    /// A generic private helper function that fetches and decodes JSON from a given endpoint.
    /// - Parameter endpoint: The URL string of the API endpoint.
    /// - Returns: A decoded object of type `T`.
    private func fetch<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        // Setting up the URLRequest with our API key as a query parameter (or Authorization header).
        // Since we have the API key in the Constants, we'll append it to the URL query here.
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        // Preserve any existing query items, then append the api_key.
        var queryItems = components.queryItems ?? []
        queryItems.append(URLQueryItem(name: "api_key", value: Constants.apiKey))
        components.queryItems = queryItems
        
        guard let finalURL = components.url else {
            throw APIError.invalidURL
        }
        
        // Performing the network request using async/await.
        let (data, response) = try await URLSession.shared.data(from: finalURL)
        
        // Checking if the HTTP response code is 200 OK.
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        // Decoding the raw JSON data into our Swift Codable models.
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding Error: \(error)")
            throw APIError.decodingError
        }
    }
    
    // MARK: - Public Endpoints
    
    /// Fetches the trending movies for the day.
    func fetchTrendingMovies() async throws -> [Movie] {
        let endpoint = "\(Constants.baseURL)/trending/movie/day"
        let response: MovieResponse = try await fetch(from: endpoint)
        return response.results
    }
    
    /// Fetches popular movies.
    func fetchPopularMovies() async throws -> [Movie] {
        let endpoint = "\(Constants.baseURL)/movie/popular"
        let response: MovieResponse = try await fetch(from: endpoint)
        return response.results
    }
    
    /// Fetches the top rated movies.
    func fetchTopRatedMovies() async throws -> [Movie] {
        let endpoint = "\(Constants.baseURL)/movie/top_rated"
        let response: MovieResponse = try await fetch(from: endpoint)
        return response.results
    }
    
    /// Fetches the official movie genres from TMDB.
    func fetchGenres() async throws -> [Genre] {
        let endpoint = "\(Constants.baseURL)/genre/movie/list"
        let response: GenreResponse = try await fetch(from: endpoint)
        return response.genres
    }
    
    /// Fetches movies belonging to a specific genre.
    func fetchMoviesByGenre(genreId: Int) async throws -> [Movie] {
        let endpoint = "\(Constants.baseURL)/discover/movie?with_genres=\(genreId)"
        let response: MovieResponse = try await fetch(from: endpoint)
        return response.results
    }
    
    /// Searches for movies based on a text query.
    func searchMovies(query: String) async throws -> [Movie] {
        // Must URL encode the query (e.g. "Star Wars" -> "Star%20Wars")
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return []
        }
        
        let endpoint = "\(Constants.baseURL)/search/movie?query=\(encodedQuery)"
        let response: MovieResponse = try await fetch(from: endpoint)
        return response.results
    }
    
    /// Fetches the detailed information for a specific movie ID.
    func fetchMovieDetails(id: Int) async throws -> Movie {
        let endpoint = "\(Constants.baseURL)/movie/\(id)"
        // Since the details endpoint directly returns a Movie JSON object (not a wrapper array),
        // we decode it directly as a Movie.
        return try await fetch(from: endpoint)
    }
}

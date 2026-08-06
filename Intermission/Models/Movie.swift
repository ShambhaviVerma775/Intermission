import Foundation

// MARK: - MovieResponse
/// A wrapper struct to decode the paginated response from TMDB.
/// TMDB returns an object with a `results` array containing the actual movies.
struct MovieResponse: Codable {
    let results: [Movie]
}

// MARK: - Movie
/// The main model representing a Movie.
/// It conforms to `Codable` for easy JSON decoding and `Identifiable` for use in SwiftUI lists/ForEach.
struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    
    // Additional fields that might only be populated when fetching movie details
    let runtime: Int?
    let genres: [Genre]?
    
    // CodingKeys map the JSON keys to our Swift property names.
    // For example, TMDB uses snake_case (`poster_path`), but Swift prefers camelCase (`posterPath`).
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case runtime
        case genres
    }
    
    /// A computed property to easily generate the full URL for the movie's poster image.
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: Constants.imageBaseURL + posterPath)
    }
    
    /// A computed property to easily generate the full URL for the movie's backdrop image.
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: Constants.imageBaseURL + backdropPath)
    }
}

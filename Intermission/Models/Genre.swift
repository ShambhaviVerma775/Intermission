import Foundation

// MARK: - GenreResponse
/// A wrapper struct to decode the genres response from TMDB.
struct GenreResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
/// Represents a movie genre.
struct Genre: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

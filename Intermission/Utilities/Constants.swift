import Foundation

struct Constants {
    // TMDB API Key
    static let apiKey = "302681e3a9970749b754603e785ba01b"
    
    // TMDB Read Access Token (Useful for Bearer token authorization if needed)
    static let readAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDI2ODFlM2E5OTcwNzQ5Yjc1NDYwM2U3ODViYTAxYiIsIm5iZiI6MTc4NjAwODU2OS42NTkwMDAyLCJzdWIiOiI2YTc0NTNmOTgzYmZiMmY4NzAzOWY5ZTgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.k0nHBGBuCys1Lbpd7CWovqNaBUvt04PoZ0WE4WIwcCg"
    
    // Base URL for all TMDB API endpoints
    static let baseURL = "https://api.themoviedb.org/3"
    
    // Base URL for fetching TMDB images (w500 specifies the width of the image)
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
}

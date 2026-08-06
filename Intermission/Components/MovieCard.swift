import SwiftUI

struct MovieCard: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            // Using AsyncImage to load the poster asynchronously from TMDB
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    // Loading placeholder
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .overlay(ProgressView())
                case .success(let image):
                    // Successfully loaded image
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                case .failure:
                    // Fallback when image fails to load
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .overlay(Image(systemName: "film").foregroundColor(.gray))
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 140, height: 210)
            .cornerRadius(12)
            
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .frame(width: 140, alignment: .leading)
        }
    }
}

#Preview {
    // Providing a dummy movie for Xcode previews
    MovieCard(movie: Movie(id: 1, title: "Preview Movie", overview: nil, posterPath: nil, backdropPath: nil, releaseDate: nil, voteAverage: 8.0, runtime: nil, genres: nil))
}

import SwiftUI

struct MovieDetailsView: View {
    
    var movieId: Int
    
    @StateObject private var viewModel = MovieDetailsViewModel()
    @EnvironmentObject var watchlistManager: WatchlistManager
    
    var body: some View {
        ScrollView {
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 100)
            }
            
            else if let movie = viewModel.movieDetails {
                
                VStack(spacing: 24) {
                    
                    // MARK: - Poster
                    
                    AsyncImage(url: movie.posterURL) { phase in
                        switch phase {
                            
                        case .empty:
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 220, height: 320)
                                .overlay(ProgressView())
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: 320)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 8)
                            
                        case .failure:
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 220, height: 320)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.system(size: 50))
                                        .foregroundColor(.gray)
                                )
                            
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    // MARK: - Movie Info Card
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 10) {
                            
                            if let rating = movie.voteAverage {
                                Label(String(format: "%.1f", rating), systemImage: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            
                            if let runtime = movie.runtime {
                                Text("•")
                                Text("\(runtime / 60)h \(runtime % 60)m")
                            }
                            
                            if let releaseDate = movie.releaseDate {
                                Text("•")
                                Text(String(releaseDate.prefix(4)))
                            }
                        }
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        
                        if let genres = movie.genres, !genres.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(genres) { genre in
                                        Text(genre.name)
                                            .font(.caption)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(.thinMaterial)
                                            .clipShape(Capsule())
                                    }
                                }
                            }
                        }
                        
                        let isInWatchlist = watchlistManager.contains(movie)
                        
                        Button {
                            watchlistManager.toggle(movie)
                        } label: {
                            
                            Label(
                                isInWatchlist ? "Added to Watchlist" : "Add to Watchlist",
                                systemImage: isInWatchlist ? "checkmark.circle.fill" : "plus.circle.fill"
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(isInWatchlist ? .green : .blue)
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    
                    // MARK: - Overview Card
                    
                    if let overview = movie.overview,
                       !overview.isEmpty {
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            Text("Overview")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text(overview)
                                .foregroundColor(.secondary)
                                .lineSpacing(5)
                        }
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            
            else if let error = viewModel.errorMessage {
                
                VStack(spacing: 16) {
                    
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    
                    Text(error)
                        .multilineTextAlignment(.center)
                    
                    Button("Retry") {
                        viewModel.fetchDetails(id: movieId)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top, 100)
            }
        }
        .navigationTitle("Movie")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.fetchDetails(id: movieId)
        }
    }
}

#Preview {
    NavigationStack {
        MovieDetailsView(movieId: 550)
            .environmentObject(WatchlistManager())
    }
}

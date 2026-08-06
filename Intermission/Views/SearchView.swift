import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    if viewModel.searchResults.isEmpty && !viewModel.isLoading {
                        EmptyStateView(
                            iconName: "magnifyingglass",
                            title: "Search Movies",
                            message: "Find your favorite movies by typing in the search bar above."
                        )
                    } else {
                        List {
                            ForEach(viewModel.searchResults) { movie in
                                NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                                    HStack(spacing: 12) {
                                        // Poster Thumbnail
                                        AsyncImage(url: movie.posterURL) { phase in
                                            switch phase {
                                            case .empty:
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.gray.opacity(0.3))
                                                    .overlay(ProgressView())
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            case .failure:
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.gray.opacity(0.3))
                                                    .overlay(Image(systemName: "film").foregroundColor(.gray))
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        .frame(width: 50, height: 75)
                                        .cornerRadius(8)
                                        
                                        // Movie Details
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(movie.title)
                                                .font(.headline)
                                            
                                            if let releaseDate = movie.releaseDate {
                                                // Extract just the year from "YYYY-MM-DD"
                                                Text(String(releaseDate.prefix(4)))
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                
                // Show loading indicator
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                
                // Show error message if it fails
                if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.performSearch()
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchQuery, prompt: "Search movies...")
            .onSubmit(of: .search) {
                // Trigger the search when the user presses return
                viewModel.performSearch()
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(WatchlistManager())
}

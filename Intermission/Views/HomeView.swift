import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // Trending Today
                        if !viewModel.trendingMovies.isEmpty {
                            VStack {
                                SectionHeader(title: "Trending Today", destination: AnyView(MovieListView(title: "Trending Today", movies: viewModel.trendingMovies)))
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.trendingMovies) { movie in
                                            NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                                                MovieCard(movie: movie)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Top Rated
                        if !viewModel.topRatedMovies.isEmpty {
                            VStack {
                                SectionHeader(title: "Top Rated", destination: AnyView(MovieListView(title: "Top Rated", movies: viewModel.topRatedMovies)))
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.topRatedMovies) { movie in
                                            NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                                                MovieCard(movie: movie)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Browse By Genre
                        if !viewModel.genres.isEmpty {
                            VStack {
                                SectionHeader(title: "Browse By Genre") // No destination needed
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.genres) { genre in
                                            NavigationLink(destination: GenreMoviesView(genre: genre)) {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(Color.accentColor.opacity(0.8))
                                                        .frame(width: 120, height: 60)
                                                    Text(genre.name)
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Perfect for Tonight (Using popular movies here)
                        if !viewModel.popularMovies.isEmpty {
                            VStack {
                                SectionHeader(title: "Perfect for Tonight", destination: AnyView(MovieListView(title: "Perfect for Tonight", movies: viewModel.popularMovies)))
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.popularMovies) { movie in
                                            NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {
                                                MovieCard(movie: movie)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 24)
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
                            viewModel.fetchHomeData()
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Home")
            // .task automatically triggers an async function when the view appears,
            // and cancels it if the view disappears before it completes!
            .task {
                viewModel.fetchHomeData()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(WatchlistManager())
}

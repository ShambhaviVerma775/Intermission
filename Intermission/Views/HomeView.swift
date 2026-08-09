import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    // MARK: - Cinematic Theme Colors
    private let backgroundColor = Color(red: 13/255, green: 13/255, blue: 13/255)      // Midnight Black
    private let cardColor = Color(red: 26/255, green: 26/255, blue: 26/255)             // Charcoal
    private let cinemaRed = Color(red: 215/255, green: 38/255, blue: 56/255)            // Deep Red
    private let softWhite = Color(red: 248/255, green: 248/255, blue: 248/255)          // Soft White

    var body: some View {
        NavigationStack {
            ZStack {
                
                // Background
                backgroundColor
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {

                        // Trending Today
                        if !viewModel.trendingMovies.isEmpty {
                            VStack {
                                SectionHeader(
                                    title: "Trending Today",
                                    destination: AnyView(
                                        MovieListView(
                                            title: "Trending Today",
                                            movies: viewModel.trendingMovies
                                        )
                                    )
                                )

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
                                SectionHeader(
                                    title: "Top Rated",
                                    destination: AnyView(
                                        MovieListView(
                                            title: "Top Rated",
                                            movies: viewModel.topRatedMovies
                                        )
                                    )
                                )

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
                                SectionHeader(title: "Browse By Genre")

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.genres) { genre in
                                            NavigationLink(destination: GenreMoviesView(genre: genre)) {

                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 14)
                                                        .fill(
                                                            LinearGradient(
                                                                colors: [
                                                                    cinemaRed,
                                                                    Color(red: 130/255, green: 18/255, blue: 34/255)
                                                                ],
                                                                startPoint: .topLeading,
                                                                endPoint: .bottomTrailing
                                                            )
                                                        )
                                                        .frame(width: 130, height: 65)
                                                        .shadow(
                                                            color: cinemaRed.opacity(0.35),
                                                            radius: 10,
                                                            y: 4
                                                        )

                                                    Text(genre.name)
                                                        .foregroundColor(softWhite)
                                                        .font(.headline)
                                                        .fontWeight(.semibold)
                                                }
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }

                        // Perfect for Tonight
                        if !viewModel.popularMovies.isEmpty {
                            VStack {
                                SectionHeader(
                                    title: "Perfect for Tonight",
                                    destination: AnyView(
                                        MovieListView(
                                            title: "Perfect for Tonight",
                                            movies: viewModel.popularMovies
                                        )
                                    )
                                )

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
                    .padding(.vertical)
                    .padding(.bottom, 24)
                }

                // Loading Indicator
                if viewModel.isLoading {
                    ProgressView()
                        .tint(cinemaRed)
                        .scaleEffect(1.5)
                }

                // Error Card
                if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {

                        Text(errorMessage)
                            .foregroundColor(softWhite)
                            .multilineTextAlignment(.center)

                        Button {
                            viewModel.fetchHomeData()
                        } label: {
                            Text("Retry")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(cinemaRed)
                                .clipShape(Capsule())
                        }
                    }
                    .padding(24)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(cinemaRed.opacity(0.25), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.35), radius: 15)
                    .padding()
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)

            .toolbarBackground(backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)

            .task {
                viewModel.fetchHomeData()
            }
        }
        .tint(cinemaRed)
    }
}

#Preview {
    HomeView()
        .environmentObject(WatchlistManager())
}

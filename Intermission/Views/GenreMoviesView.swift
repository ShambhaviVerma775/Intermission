import SwiftUI

struct GenreMoviesView: View {
    var genre: Genre
    @StateObject private var viewModel = GenreMoviesViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private let backgroundColor = Color(red: 13/255, green: 13/255, blue: 13/255)
    private let cardColor = Color(red: 26/255, green: 26/255, blue: 26/255)
    private let cinemaRed = Color(red: 215/255, green: 38/255, blue: 56/255)

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailsView(movieId: movie.id)) {

                            MovieCard(movie: movie)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(cardColor.opacity(0.85))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white.opacity(0.05), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.25), radius: 10, y: 5)

                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }

            if viewModel.isLoading {
                ProgressView()
                    .tint(cinemaRed)
                    .scaleEffect(1.5)
            }

            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Button("Retry") {
                        viewModel.fetchMovies(for: genre.id)
                    }
                    
                    .padding(.top, 8)
                    .tint(cinemaRed)
                    
                }
                .padding()
                .background(cardColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .navigationTitle(genre.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(backgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .tint(cinemaRed)
        .task {
            viewModel.fetchMovies(for: genre.id)
        }
    }
}

#Preview {
    NavigationStack {
        GenreMoviesView(genre: Genre(id: 28, name: "Action"))
            .environmentObject(WatchlistManager())
    }
}

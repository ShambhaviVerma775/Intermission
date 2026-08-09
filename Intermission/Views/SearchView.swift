import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    private let backgroundColor = Color(red: 13/255, green: 13/255, blue: 13/255)
    private let cardColor = Color(red: 26/255, green: 26/255, blue: 26/255)
    private let cinemaRed = Color(red: 215/255, green: 38/255, blue: 56/255)
    private let softWhite = Color(red: 248/255, green: 248/255, blue: 248/255)

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()

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

                                        AsyncImage(url: movie.posterURL) { phase in
                                            switch phase {
                                            case .empty:
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(cardColor)
                                                    .overlay(ProgressView().tint(cinemaRed))

                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)

                                            case .failure:
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(cardColor)
                                                    .overlay(
                                                        Image(systemName: "film")
                                                            .foregroundColor(.gray)
                                                    )

                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        .frame(width: 50, height: 75)
                                        .cornerRadius(8)

                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(movie.title)
                                                .font(.headline)
                                                .foregroundColor(softWhite)

                                            if let releaseDate = movie.releaseDate {
                                                Text(String(releaseDate.prefix(4)))
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                                .listRowBackground(cardColor)
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .tint(cinemaRed)
                        .scaleEffect(1.5)
                }

                if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(errorMessage)
                            .foregroundColor(softWhite)

                        Button("Retry") {
                            viewModel.performSearch()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(cinemaRed)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                    .padding()
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .navigationTitle("Search")
            .toolbarBackground(Color(red: 13/255, green: 13/255, blue: 13/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(text: $viewModel.searchQuery, prompt: "Search movies...")
            .tint(cinemaRed)

            .onSubmit(of: .search) {
                viewModel.performSearch()
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(WatchlistManager())
}

import SwiftUI

struct MovieDetailsView: View {
    var movieId: Int

    @StateObject private var viewModel = MovieDetailsViewModel()
    @EnvironmentObject var watchlistManager: WatchlistManager

  
    private let backgroundColor = Color(red: 13/255, green: 13/255, blue: 13/255)
    private let cardColor = Color(red: 26/255, green: 26/255, blue: 26/255)
    private let cinemaRed = Color(red: 215/255, green: 38/255, blue: 56/255)
    private let softWhite = Color(red: 248/255, green: 248/255, blue: 248/255)
    private let gold = Color(red: 244/255, green: 185/255, blue: 66/255)
    private let successGreen = Color(red: 46/255, green: 184/255, blue: 92/255)

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            ScrollView {

                if viewModel.isLoading {

                    ProgressView()
                        .tint(cinemaRed)
                        .padding(.top, 100)

                } else if let movie = viewModel.movieDetails {

                    VStack(spacing: 24) {

                        // MARK: Poster

                        AsyncImage(url: movie.posterURL) { phase in
                            switch phase {

                            case .empty:
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(cardColor)
                                    .frame(width: 220, height: 320)
                                    .overlay(
                                        ProgressView()
                                            .tint(cinemaRed)
                                    )

                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 220, height: 320)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: .black.opacity(0.5), radius: 12)

                            case .failure:
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(cardColor)
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

                        // MARK: Info Card

                        VStack(alignment: .leading, spacing: 16) {

                            Text(movie.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(softWhite)

                            HStack(spacing: 10) {

                                if let rating = movie.voteAverage {
                                    Label(String(format: "%.1f", rating), systemImage: "star.fill")
                                        .foregroundColor(gold)
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
                            .foregroundColor(.gray)
                            .font(.subheadline)

                            if let genres = movie.genres, !genres.isEmpty {

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach(genres) { genre in
                                            Text(genre.name)
                                                .font(.caption)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 8)
                                                .background(cardColor)
                                                .overlay(
                                                    Capsule()
                                                        .stroke(cinemaRed.opacity(0.35), lineWidth: 1)
                                                )
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
                            .tint(isInWatchlist ? successGreen : cinemaRed)
                        }
                        .padding()
                        .background(cardColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white.opacity(0.05), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)

                        // MARK: Overview

                        if let overview = movie.overview,
                           !overview.isEmpty {

                            VStack(alignment: .leading, spacing: 12) {

                                Text("Overview")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)

                                Text(overview)
                                    .foregroundColor(.gray)
                                    .lineSpacing(5)
                            }
                            .padding()
                            .background(cardColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white.opacity(0.05), lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)

                } else if let error = viewModel.errorMessage {

                    VStack(spacing: 16) {

                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundColor(cinemaRed)

                        Text(error)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Button("Retry") {
                            viewModel.fetchDetails(id: movieId)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(cinemaRed)
                    }
                    .padding(.top, 100)
                }
            }
        }
        .navigationTitle("Movie")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(backgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .tint(cinemaRed)
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

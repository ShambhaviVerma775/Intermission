import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                
                    VStack {
                        SectionHeader(title: "Trending Today")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.trendingMovies, id: \.self) { movie in
                                    NavigationLink(destination: MovieDetailsView()) {
                                        MovieCard(title: movie)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Top Rated
                    VStack {
                        SectionHeader(title: "Top Rated")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.topRatedMovies, id: \.self) { movie in
                                    NavigationLink(destination: MovieDetailsView()) {
                                        MovieCard(title: movie)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    VStack {
                        SectionHeader(title: "Browse By Genre")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.browseByGenre, id: \.self) { genre in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.accentColor.opacity(0.8))
                                            .frame(width: 120, height: 60)
                                        Text(genre)
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    VStack {
                        SectionHeader(title: "Perfect for Tonight")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(1..<4) { index in
                                    NavigationLink(destination: MovieDetailsView()) {
                                        MovieCard(title: "Suggestion \(index)")
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 24)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}

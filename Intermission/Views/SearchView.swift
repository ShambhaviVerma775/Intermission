import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.searchQuery.isEmpty {
                    EmptyStateView(
                        iconName: "magnifyingglass",
                        title: "Search Movies",
                        message: "Find your favorite movies, actors, or genres."
                    )
                } else {
                    List {
                        ForEach(1..<6) { index in
                            NavigationLink(destination: MovieDetailsView()) {
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 50, height: 75)
                                        .overlay {
                                            Image(systemName: "film")
                                                .foregroundColor(.gray)
                                        }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Result \(index) for \"\(viewModel.searchQuery)\"")
                                            .font(.headline)
                                        Text("2026 • Action")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.searchQuery, prompt: "Search movies...")
        }
    }
}

#Preview {
    SearchView()
}

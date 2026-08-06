import SwiftUI

struct MovieDetailsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header (Poster Placeholder)
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 300)
                        .overlay {
                            Image(systemName: "photo")
                                .font(.system(size: 60))
                                .foregroundColor(.gray.opacity(0.5))
                        }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Metadata
                    Text("Placeholder Movie Title")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 12) {
                        Label("8.5/10", systemImage: "star.fill")
                            .foregroundColor(.yellow)
                        Text("•")
                        Text("2h 15m")
                        Text("•")
                        Text("2026")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    // Genres
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(["Action", "Sci-Fi", "Adventure"], id: \.self) { genre in
                                Text(genre)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.secondary.opacity(0.2))
                                    .cornerRadius(16)
                            }
                        }
                    }
                    
                    // Action Buttons
                    HStack(spacing: 16) {
                        Button {
                            // TODO: Add to watchlist
                        } label: {
                            Label("Watchlist", systemImage: "plus")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }
                    .padding(.top, 8)
                    
                    // Overview
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Overview")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("This is a placeholder description for the movie. It provides a brief overview of the plot, the main characters, and the setting. When real API integration is added, this text will display the actual synopsis fetched from the server.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MovieDetailsView()
    }
}

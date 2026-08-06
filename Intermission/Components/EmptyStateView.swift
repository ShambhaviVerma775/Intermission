import SwiftUI

struct EmptyStateView: View {
    var iconName: String
    var title: String
    var message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: iconName)
                .font(.system(size: 80))
                .foregroundColor(.gray.opacity(0.6))
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView(iconName: "bookmark", title: "No movies yet", message: "Add some movies to your watchlist to see them here.")
}

import SwiftUI

struct MovieCard: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 140, height: 210)
                .overlay {
                    Image(systemName: "film")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
            
            Text(title)
                .font(.headline)
                .lineLimit(2)
                .frame(width: 140, alignment: .leading)
        }
    }
}

#Preview {
    MovieCard(title: "Placeholder Movie")
}

import SwiftUI

struct SectionHeader: View {
    var title: String
    var destination: AnyView? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.cinemaWhite)
            
            Spacer()
            
            if let dest = destination {
                NavigationLink(destination: dest) {
                    Text("See All")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.cinemaRed)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    SectionHeader(title: "Trending Today")
}

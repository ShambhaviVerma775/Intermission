import SwiftUI

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                // TODO: Handle see all action
            } label: {
                Text("See All")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    SectionHeader(title: "Trending Today")
}

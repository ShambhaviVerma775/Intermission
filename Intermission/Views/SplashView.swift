import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            MainTabView()
        } else {
            VStack {
                Image(systemName: "film.stack")
                    .font(.system(size: 80))
                    .foregroundColor(.accentColor)
                
                Text("Intermission")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 16)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(WatchlistManager())
}

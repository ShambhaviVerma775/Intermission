import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        if isActive {
            MainTabView()
        } else {
            ZStack {
                Color.cinemaBackground.ignoresSafeArea()
                
                VStack {
                    Image(systemName: "film.stack")
                        .font(.system(size: 80))
                        .foregroundColor(.cinemaRed)
                    
                    Text("Intermission")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.cinemaWhite)
                        .padding(.top, 16)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
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

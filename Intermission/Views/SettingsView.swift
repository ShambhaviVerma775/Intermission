import SwiftUI
//no ViewModel because it doesn't fetch or process data.
struct SettingsView: View {
    @EnvironmentObject var watchlistManager: WatchlistManager
//Here it's used for one purpose only:Clearing the shared watchlist.
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 13/255, green: 13/255, blue: 13/255)
                    .ignoresSafeArea()

                List {
                    Section("Account") { //A Section groups related rows together.
                        Button(role: .destructive) {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                watchlistManager.clear()
                            }
                        } label: {
                            Text("Clear Watchlist")
                                .foregroundColor(Color(red: 215/255, green: 38/255, blue: 56/255))
                        }
                        .buttonStyle(.borderless)
                        .listRowBackground(Color(red: 26/255, green: 26/255, blue: 26/255))
                    }

                    Section("About") {
                        HStack {
                            Text("Version")
                                .foregroundColor(.white)

                            Spacer()

                            Text("1.0.0 (1)")
                                .foregroundColor(.gray)
                        }

                        NavigationLink("About") {
                            ZStack {
                                Color(red: 13/255, green: 13/255, blue: 13/255)
                                    .ignoresSafeArea()

                                Text("The INTERMISSION app is a SwiftUI movie discovery app built for iOS. It has the TMDB(The movie database) API integrated and lets you browse trending films,explore movies by genre, search titles of your interests, and offeres to save movies to your personal watchlist. The color scheme/theme in the UI is inspired by theatre colors like Cinema Red, Cinema white, Cinema black and etc and is similar to that of netflix/CineBy. This project doesn't have that much of a real life implementation but it for sure covers a variety of major concepts that form the base of iOS development.")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                            }
                            .navigationTitle("About")
                            .toolbarBackground(Color(red: 13/255, green: 13/255, blue: 13/255), for: .navigationBar)
                            .toolbarBackground(.visible, for: .navigationBar)
                            .toolbarColorScheme(.dark, for: .navigationBar)
                        }
                        .foregroundColor(.white)
                       
                    }
                    .listRowBackground(Color(red: 26/255, green: 26/255, blue: 26/255))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .toolbarBackground(Color(red: 13/255, green: 13/255, blue: 13/255), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
         
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(WatchlistManager())
}


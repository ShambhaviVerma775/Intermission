import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var watchlistManager: WatchlistManager

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 13/255, green: 13/255, blue: 13/255)
                    .ignoresSafeArea()

                List {
                    Section("Account") {
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

                                Text("About Intermission")
                                    .foregroundColor(.white)
                                    .font(.title3)
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

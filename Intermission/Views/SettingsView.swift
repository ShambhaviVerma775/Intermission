import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Account")) {
                    Button(role: .destructive) {
                        // TODO: Handle clear watchlist
                    } label: {
                        Text("Clear Watchlist")
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0 (1)")
                            .foregroundColor(.secondary)
                    }
                    
                    NavigationLink(destination: Text("About Intermission").navigationTitle("About")) {
                        Text("About")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}

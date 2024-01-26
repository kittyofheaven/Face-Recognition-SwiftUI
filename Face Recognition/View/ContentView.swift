//
//  ContentView.swift
//  Face Recognition
//
//  Created by Hazel Handrata on 25/01/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
<<<<<<< Updated upstream
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            StillFacesView()
        }
=======
    var body: some View {
        LiveCameraView()
>>>>>>> Stashed changes
    }
}

#Preview {
    ContentView()
<<<<<<< Updated upstream
        .modelContainer(for: Item.self, inMemory: true)
=======
>>>>>>> Stashed changes
}

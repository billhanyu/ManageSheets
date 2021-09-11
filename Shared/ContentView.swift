//
//  ContentView.swift
//  Shared
//
//  Created by Bill Yu on 9/9/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var addingNew = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var newSong = SongViewModel()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Song.name, ascending: true)],
        animation: .default)
    private var songs: FetchedResults<Song>
    
    var body: some View {
        List {
            ForEach(songs) { song in
                NavigationLink(destination: SongView(songViewModel: SongViewModel(from: song))) {
                    song.name.map(Text.init)
                }
            }
            .onDelete { indices in
                withAnimation {
                    indices.map { songs[$0] }.forEach(viewContext.delete)
                    saveContext()
                }
            }
        }
        .navigationTitle("My Sheets")
        .navigationBarItems(trailing: Button(action: {
            addingNew = true
        }) {
            Image(systemName: "plus")
        })
        .fullScreenCover(isPresented: $addingNew) {
            NavigationView {
                EditView(songViewModel: newSong)
                    .navigationTitle("New Song")
                    .navigationBarItems(leading: Button("Cancel") {
                        addingNew = false
                    }, trailing: Button("Done") {
                        addingNew = false
                        DispatchQueue.global(qos: .userInitiated).async {
                            let _ = newSong.toSong(viewContext: viewContext)
                            saveContext()
                        }
                    }).environment(\.managedObjectContext, viewContext)
            }
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.preview
        NavigationView {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  ContentView.swift
//  HelloCoreData
//
//  Created by Ian Manor on 20/01/21.
//

import SwiftUI

struct ContentView: View {
    let storageProvider: StorageProvider
    @State var movieName: String = ""
    @State var movies: [Movie] = []

    var body: some View {
        TextField("Movie Name", text: $movieName)
        Button {
            storageProvider.saveMovie(named: movieName)
        } label: {
            Text("Save")
        }
        Button {
            movies = storageProvider.getAllMovies()
        } label: {
            Text("Fetch")
        }
        List(movies, id: \.name) { movie in
            HStack {
                TextField("", text: .init(get: {
                    movie.name!
                }, set: { name in
                    movie.name = name
                }))
                Button {
                    storageProvider.updateMovies()
                } label: {
                    Text("Update")
                }
                Button {
                    storageProvider.deleteMovie(movie)
                } label: {
                    Text("Delete")
                }
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

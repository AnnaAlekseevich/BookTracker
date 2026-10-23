//
//  ContentView.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 05/10/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var model = BooksViewModel()

    var body: some View {
        NavigationStack(path: $model.path) {
            VStack {
                List {
                    ForEach(model.books) { book in
                        BookRowView(book: book)
                    }
                    .onDelete { index in
                        model.deleteBook(index: index)
                    }
                    .onMove { index, destination in
                        model.moveBook(index: index, destination: destination)
                    }
                    Button(action: model.addBook) {
                        Text("add book")
                    }
                }
                .listStyle(.plain)

                Button(action: model.openBoorsWishListScreen) {
                    Text("Books Wish List")
                }
            }
            .toolbar { EditButton() }
            .navigationDestination(for: BooksRoute.self) { route in
                switch route {
                case .wishList:
                    BooksWishListView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

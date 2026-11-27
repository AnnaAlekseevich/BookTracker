//
//  BooksWishListView.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 22/10/2026.
//

import SwiftUI

struct BooksWishListView: View {
    @State private var model: BooksWishListViewModel
    
    init(model: BooksWishListViewModel) {
        _model = State(initialValue: model)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
                .frame(maxHeight: .infinity)
        }
        .navigationTitle("Books Wish List")
        .navigationDestination(item: $model.selectedBook) { book in
            BookDetailsView(model: .init(book: book, storage: model.storage))
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch model.state {
        case .empty:
            ContentUnavailableView(
                "Wish list is empty",
                systemImage: "heart",
                description: Text("Tap + to add a book you want to read.")
            )
        case .filled:
            List {
                ForEach(model.books) { book in
                    BookRowView(
                        book: book,
                        isInReadingList: true,
                        onToggleWishList: {
                            model.toggleWishList(book)
                        },
                        onOpenBookDetails: {
                            model.openBookDetails(book)
                        }
                    )
                }
                .onDelete(perform: model.deleteBook)
            }
            .listStyle(.plain)
        }
    }
}

#Preview("Empty") {
    NavigationStack { BooksWishListView(model: .init(storage: BooksWishListStorage())) }
}
#Preview("Filled") {
    NavigationStack { BooksWishListView(model: .init(storage: BooksWishListStorage(books: Book.samples))) }
}

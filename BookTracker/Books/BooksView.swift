//
//  BooksView.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 23/10/2026.
//

import SwiftUI

struct BooksView: View {
    @State private var model = BooksViewModel()

    var body: some View {
        NavigationStack(path: $model.path) {
            if model.isLoading {
                ProgressView()
            } else if let errorMessage = model.errorMessage {
                ContentUnavailableView {
                    Label("Couldn't load books", systemImage: "wifi.exclamationmark")
                } description: {
                    Text(errorMessage)
                } actions: {
                    Button("Try again") {
                        Task { await model.loadBooks() }
                    }
                }
            } else {
                contentView
            }
        }.task {
            await model.loadBooks()
        }
    }
    
    var contentView: some View {
        VStack {
            List {
                Text("count = \(model.booksWishList.count)")
                ForEach(model.books) { book in
                    BookRowView(
                        book: book,
                        isInReadingList: model.isInWishList(book),
                        onToggleWishList: {
                            model.toggleWishList(book)
                        },
                        onOpenBookDetails: {
                            model.openBookDetails(book)
                        }
                    )
                }

                if model.canLoadMore {
                    loadMoreView
                }
            }
            .listStyle(.plain)

            Button(action: model.openBooksWishListScreen) {
                Text("Books Wish List")
            }
            
//            NavigationLink(destination: BooksWishListView()) {
//                Text("Books Wish List")
//            }
        }
        .navigationDestination(for: BooksRoute.self) { route in
            switch route {
            case let .wishList(books):
                BooksWishListView(model: BooksWishListViewModel(books: books, onOpenBookDetails: { book in
                    model.openBookDetails(book)
                }))
            case let .bookDetails(book):
                BookDetailsView(model: .init(book: book))
            }
        }
    }

    private var loadMoreView: some View {
        HStack {
            Spacer()
            if model.loadMoreFailed {
                Button("Couldn't load more. Try again") {
                    Task { await model.loadMoreBooks() }
                }
            } else {
                ProgressView()
            }
            Spacer()
        }
        .listRowSeparator(.hidden)
        .task(id: model.nextOffset) {
            await model.loadMoreBooks()
        }
    }

}

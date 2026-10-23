//
//  BooksWishListView.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 22/10/2026.
//

import SwiftUI

struct BooksWishListView: View {
    @State private var model: BooksWishListViewModel
    @FocusState private var isTitleFocused: Bool

    init(model: BooksWishListViewModel = BooksWishListViewModel()) {
        _model = State(initialValue: model)
    }

    var body: some View {
        VStack(spacing: 0) {
            if model.isShowAddBookView {
                addBookView
            }
            content
                .frame(maxHeight: .infinity)
        }
        .navigationTitle("Books Wish List")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: model.showAddBookView) {
                    Label("Add book", systemImage: "plus")
                }
            }
        }
    }

    private var addBookView: some View {
        HStack {
            TextField("Write your book title", text: $model.newBookTitle)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .focused($isTitleFocused)
                .onSubmit(model.addBookToList)

            Button("Add", action: model.addBookToList)
                .disabled(!model.canAddBook)

            Button(action: model.hideAddBookView) {
                Label("Cancel", systemImage: "xmark")
                    .labelStyle(.iconOnly)
            }
        }
        .padding()
        .onAppear { isTitleFocused = true }
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
                    BookRowView(book: book)
                }
                .onDelete(perform: model.deleteBook)
            }
            .listStyle(.plain)
        }
    }
}

#Preview("Empty") {
    NavigationStack {
        BooksWishListView()
    }
}

#Preview("Filled") {
    NavigationStack {
        BooksWishListView(model: BooksWishListViewModel(books: Book.samples))
    }
}

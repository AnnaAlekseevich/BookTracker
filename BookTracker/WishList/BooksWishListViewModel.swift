//
//  BooksWishListViewModel.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 22/10/2026.
//

import Foundation
import Observation

enum BooksWishListState {
    case empty
    case filled
}

@Observable
final class BooksWishListViewModel {
    var books: [Book]
    var isShowAddBookView = false
    var newBookTitle = ""

    var state: BooksWishListState {
        if books.isEmpty { .empty } else { .filled }
    }

    var canAddBook: Bool {
        !newBookTitle.trimmingCharacters(in: .whitespaces).isEmpty
    }

    init(books: [Book] = []) {
        self.books = books
    }

    func showAddBookView() {
        isShowAddBookView = true
    }

    func hideAddBookView() {
        isShowAddBookView = false
        newBookTitle = ""
    }

    func addBookToList() {
        guard canAddBook else { return }

        books.append(
            Book(
                id: UUID().uuidString,
                title: newBookTitle.trimmingCharacters(in: .whitespaces),
                description: "A book you want to read.",
                coverURL: nil
            )
        )
        hideAddBookView()
    }

    func deleteBook(index: IndexSet) {
        books.remove(atOffsets: index)
    }
}

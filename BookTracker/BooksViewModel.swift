//
//  BooksViewModel.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 16/10/2026.
//

import SwiftUI
import Observation

enum BooksRoute: Hashable {
    case wishList
}

@Observable
class BooksViewModel {
    var books: [Book] = Book.samples
    var path: [BooksRoute] = []

    func addBook() {
        print("### addBook")
        print("### books = \(books.count)")
        books.append(Book(id: "123321", title: "TestTitle", description: "simple description", coverURL: nil))
        print("### books = \(books.count)")
    }
    
    func deleteBook(index: IndexSet) {
        books.remove(atOffsets: index)
    }
    
    func moveBook(index: IndexSet, destination: Int) {
        books.move(fromOffsets: index, toOffset: destination)
    }
    
    func openBoorsWishListScreen() {
        path.append(.wishList)
    }
}

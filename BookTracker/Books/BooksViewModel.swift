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
    case bookDetails(book: Book)
}

@MainActor
@Observable
class BooksViewModel {
    var books: [Book] = []
    let storage: BooksWishListStorage
    var path: [BooksRoute] = []
    private let api = BooksApi()
    private let pageSize = 20
    private let maxBooks = 1000
    private(set) var nextOffset = 0
    private(set) var state: BooksState = .loading
    var booksWishList: [Book] { storage.books }
    
    init(storage: BooksWishListStorage) {
        self.storage = storage
    }

    //move to extension
    enum BooksState: Equatable {
        case loading
        case loaded
        case loadingMore
        case loadMoreFailed
        case finished
        case error(String)
    }

    func loadBooks() async {
        state = .loading

        do {
            let response = try await api.loadBooks(offset: 0, limit: pageSize)

            books = []
            nextOffset = 0
            appendPage(response)
        } catch {
            print("Loading error: \(error)")
            state = .error(error.localizedDescription)
        }
    }

    func loadMoreBooks() async {
        switch state {
            case .loaded, .loadMoreFailed:
                break
            default:
                return
            }

        state = .loadingMore
        do {
            let limit = min(pageSize, maxBooks - nextOffset)
            let response = try await api.loadBooks(offset: nextOffset, limit: limit)

            appendPage(response)
        } catch {
            print("Loading more error: \(error)")
            state = .loadMoreFailed
        }
    }

    private func appendPage(_ response: BooksResponse) {
        let loadedIds = Set(books.map(\.id))
        let newBooks = response.docs
            .map { $0.makeBook() }
            .filter { !loadedIds.contains($0.id) }

        books.append(contentsOf: newBooks)
        nextOffset += response.docs.count
        let canLoadMore = !response.docs.isEmpty && nextOffset < min(maxBooks, response.numFound)

        state = canLoadMore ? .loaded : .finished
    }
    
    func isInWishList(_ book: Book) -> Bool {
        storage.contains(book: book)
    }
    
    func toggleWishList(_ book: Book) {
        storage.toggle(book: book)
    }
    
    func openBookDetails(_ book: Book) {
        path.append(.bookDetails(book: book))
    }
    
    func openBooksWishListScreen() {
        path.append(.wishList)
    }
}

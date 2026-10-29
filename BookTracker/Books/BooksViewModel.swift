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

@MainActor
@Observable
class BooksViewModel {
    var books: [Book] = []
    var booksWishList: [Book] = []
    var path: [BooksRoute] = []
    private let api = BooksApi()
    private let pageSize = 20
    private let maxBooks = 1000
    private(set) var nextOffset = 0

    private(set) var isLoading = true
    private(set) var errorMessage: String?
    private(set) var isLoadingMore = false
    private(set) var loadMoreFailed = false
    private(set) var canLoadMore = false

    func loadBooks() async {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }
        do {
            let response = try await api.loadBooks(offset: 0, limit: pageSize)

            books = []
            nextOffset = 0
            appendPage(response)
        } catch {
            print("Loading error: \(error)")
            errorMessage = error.localizedDescription
        }
    }

    func loadMoreBooks() async {
        guard canLoadMore, !isLoadingMore else { return }

        isLoadingMore = true
        loadMoreFailed = false

        defer { isLoadingMore = false }
        do {
            let limit = min(pageSize, maxBooks - nextOffset)
            let response = try await api.loadBooks(offset: nextOffset, limit: limit)

            appendPage(response)
        } catch {
            print("Loading more error: \(error)")
            loadMoreFailed = true
        }
    }

    private func appendPage(_ response: BooksResponse) {
        let loadedIds = Set(books.map(\.id))
        let newBooks = response.docs
            .map { $0.makeBook() }
            .filter { !loadedIds.contains($0.id) }

        books.append(contentsOf: newBooks)
        nextOffset += response.docs.count
        canLoadMore = !response.docs.isEmpty && nextOffset < min(maxBooks, response.numFound)
    }
    
    func isInWishList(_ book: Book) -> Bool {
        booksWishList.contains { $0.id == book.id }
    }
    
    func toggleWishList(_ book: Book) {
        if isInWishList(book) {
            booksWishList.removeAll { $0.id == book.id }
        } else {
            booksWishList.append(book)
        }
    }
    
    func openBoorsWishListScreen() {
        path.append(.wishList)
    }
}

//
//  BookRowView.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 06/10/2026.
//

import SwiftUI

struct BookRowView: View {
    let book: Book
    let isInReadingList: Bool
    let onToggleWishList: () -> Void
    
    var body: some View {
            HStack(alignment: .top, spacing: 16) {
                cover
                    .frame(width: 60, height: 90)
                    .background(Color(.secondarySystemFill))
                    .clipShape(RoundedRectangle(cornerRadius: 6))

                VStack(alignment: .leading, spacing: 4) {
                    Text(book.title)
                        .font(.headline)
                        .lineLimit(2)

                    Text(book.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(3)
                }

                Spacer(minLength: 0)

                addBookCheckBox
            }
            .padding(.vertical, 8)
        }

        private var addBookCheckBox: some View {
            Button {
                onToggleWishList()
            } label: {
                Image(systemName: isInReadingList
                      ? "checkmark.square.fill"
                      : "square")
                    .font(.title2)
                    .foregroundStyle(
                        isInReadingList ? .blue : .secondary
                    )
            }
            .buttonStyle(.borderless)
        }
    
    private var cover: some View {
        AsyncImage(url: book.coverURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .empty where book.coverURL != nil:
                ProgressView()
            default:
                Image(systemName: "book.closed")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("Single row") {
    BookRowView(book: Book.samples[0], isInReadingList: true, onToggleWishList: {})
        .padding()
}

#Preview("List") {
    List(Book.samples) { book in
        BookRowView(book: book, isInReadingList: false, onToggleWishList: {})
    }
}

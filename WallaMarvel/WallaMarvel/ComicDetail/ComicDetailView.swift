//
//  ComicDetailView.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 7/4/25.
//

import SwiftUI
import Kingfisher

struct ComicDetailView: View {
    let comic: Comic

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(comicImageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .padding(.horizontal)

                Text(comic.title)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .accessibilityIdentifier("comicDetailTitle")

                if let description = comic.description, !description.isEmpty {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                }

                if comic.pageCount > 0 {
                    Text("Pages: \(comic.pageCount)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }

                if let onsaleDate = comic.dates.first(where: { $0.type == "onsaleDate" })?.date,
                   let date = formatted(dateString: onsaleDate) {
                    Text("On Sale: \(date)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle(comic.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var comicImageURL: URL? {
        guard let thumbnail = comic.thumbnail else { return nil }
        return URL(string: "\(thumbnail.path)/portrait_uncanny.\(thumbnail.extension)")
    }

    private func formatted(dateString: String) -> String? {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return nil
    }
}


#Preview {
    ComicDetailView(comic: Comic(id: 1, title: "some title", description: "some description", pageCount: 10, thumbnail: nil, dates: []))
}

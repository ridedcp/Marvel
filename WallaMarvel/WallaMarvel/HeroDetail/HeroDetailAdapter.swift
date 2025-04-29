//
//  HeroDetailAdapter.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 7/4/25.
//

import UIKit

final class HeroDetailAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    private var comics: [Comic]
    private var onSelect: (Comic) -> Void

    init(comics: [Comic], onSelect: @escaping (Comic) -> Void) {
        self.comics = comics
        self.onSelect = onSelect
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCell", for: indexPath) as? ComicCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: comics[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect(comics[indexPath.item])
    }
}

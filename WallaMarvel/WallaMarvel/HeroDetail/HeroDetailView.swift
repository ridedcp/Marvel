//
//  HeroDetailView.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 7/4/25.
//

import UIKit

final class HeroDetailView: UIView {

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()

    let comicsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comics"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let itemWidth = (UIScreen.main.bounds.width - 16 * 2 - spacing * 2) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemBackground
        addSubview(imageView)
        addSubview(comicsTitleLabel)
        addSubview(comicsCollectionView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            comicsTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            comicsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            comicsTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            comicsCollectionView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: 12),
            comicsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            comicsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            comicsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//
//  Untitled.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 2/4/25.
//

import UIKit
import SwiftUI
import Kingfisher

final class HeroDetailViewController: UIViewController {
    private var presenter: HeroDetailPresenterProtocol
    
    private var comicsAdapter: HeroDetailAdapter?

    private let imageView = UIImageView()
    private let comicsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comics"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()

    private lazy var comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let itemWidth = (UIScreen.main.bounds.width - 16 * 2 - spacing * 2) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: "ComicCell")
        return collectionView
    }()
    
    init(presenter: HeroDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.ui = self
        self.title = presenter.screenTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        presenter.onViewLoaded()
    }
    
    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

        comicsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsTitleLabel.text = "Comics"
        comicsTitleLabel.font = .boldSystemFont(ofSize: 20)

        view.addSubview(imageView)
        view.addSubview(comicsTitleLabel)
        view.addSubview(comicsCollectionView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            comicsTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            comicsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            comicsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            comicsCollectionView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: 12),
            comicsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            comicsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            comicsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HeroDetailViewController: HeroDetailUI {
    func showHero(name: String, imageURL: URL?) {
        imageView.kf.setImage(with: imageURL)
    }
    
    func showComics(_ comics: [Comic]) {
        DispatchQueue.main.async {
            self.comicsAdapter = HeroDetailAdapter(comics: comics) { [weak self] comic in
                let swiftUIView = ComicDetailView(comic: comic)
                let hostingVC = UIHostingController(rootView: swiftUIView)
                self?.navigationController?.pushViewController(hostingVC, animated: true)
            }
            self.comicsCollectionView.dataSource = self.comicsAdapter
            self.comicsCollectionView.delegate = self.comicsAdapter
            self.comicsCollectionView.reloadData()
        }
    }
}

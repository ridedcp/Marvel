import Foundation
import UIKit

final class ListHeroesView: UIView {
    enum Constant {
        static let estimatedRowHeight: CGFloat = 120
    }
    
    let heroesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListHeroesTableViewCell.self, forCellReuseIdentifier: "ListHeroesTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constant.estimatedRowHeight
        return tableView
    }()
    
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No heroes found"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "emptyStateLabel"
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        addContraints()
    }
    
    private func addSubviews() {
        addSubview(heroesTableView)
        addSubview(noResultsLabel)
        addSubview(activityIndicator)
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            heroesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesTableView.topAnchor.constraint(equalTo: topAnchor),
            heroesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noResultsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func showEmptyState() {
        noResultsLabel.isHidden = false
        heroesTableView.isHidden = true
    }

    func hideEmptyState() {
        noResultsLabel.isHidden = true
        heroesTableView.isHidden = false
    }
}

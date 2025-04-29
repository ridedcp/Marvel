import UIKit

final class ListHeroesViewController: UIViewController {
    var mainView: ListHeroesView { return view as! ListHeroesView }
    
    var presenter: ListHeroesPresenterProtocol?
    var listHeroesProvider: ListHeroesAdapter?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchDebounceWorkItem: DispatchWorkItem?

    override func loadView() {
        view = ListHeroesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        listHeroesProvider = ListHeroesAdapter(tableView: mainView.heroesTableView)
        presenter?.getHeroes()
        presenter?.ui = self
        
        title = presenter?.screenTitle()
        
        mainView.heroesTableView.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search heroes"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension ListHeroesViewController: ListHeroesUI {
    func update(heroes: [CharacterDataModel]) {
        DispatchQueue.main.async {
            if heroes.isEmpty {
                self.mainView.showEmptyState()
            } else {
                self.mainView.hideEmptyState()
                self.listHeroesProvider?.heroes = heroes
            }
        }
    }
    
    func showLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            if loading {
                self.mainView.activityIndicator.startAnimating()
                self.view.isUserInteractionEnabled = false
            } else {
                self.mainView.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}

extension ListHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedHero = listHeroesProvider?.heroes[indexPath.row] else { return }
        let detailVC = HeroDetailBuilder.build(hero: selectedHero)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > contentHeight - frameHeight - 100 {
            presenter?.getHeroes()
        }
    }
}

extension ListHeroesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        searchDebounceWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.presenter?.filterHeroes(with: query)
        }

        searchDebounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
}

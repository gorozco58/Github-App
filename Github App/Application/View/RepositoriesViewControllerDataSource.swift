import UIKit

protocol RepositoriesViewControllerDataSourceProvider: AnyObject {
    var repos: [Repository] { get }
    
    func repositoriesViewControllerDidSelectRepository(_ repo: Repository)
}

class RepositoriesViewControllerDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var provider: RepositoriesViewControllerDataSourceProvider?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider?.repos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repo = provider?.repos[indexPath.row] else { return UITableViewCell() }
        let cell: RepositoryCell = tableView.dequeueCell(at: indexPath)
        cell.setupView(with: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repo = provider?.repos[indexPath.row] else { return }
        provider?.repositoriesViewControllerDidSelectRepository(repo)
    }
}

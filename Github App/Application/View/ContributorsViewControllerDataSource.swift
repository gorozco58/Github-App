import UIKit

protocol ContributorsViewControllerDataSourceProvider: AnyObject {
    var contributors: [Contributor] { get }
}

class ContributorsViewControllerDataSource: NSObject, UITableViewDataSource {
    weak var provider: ContributorsViewControllerDataSourceProvider?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider?.contributors.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contributor = provider?.contributors[indexPath.row] else { return UITableViewCell() }
        let cell: ContributorCell = tableView.dequeueCell(at: indexPath)
        cell.setupView(with: contributor)
        return cell
    }
}


import UIKit

extension UITableView {
    
    public func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        let bundle = Bundle(for: T.self)
        register(UINib(nibName: String(describing: cellClass), bundle: bundle), forCellReuseIdentifier: String(describing: cellClass))
    }
    
    public func registerSupplementaryView<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        let bundle = Bundle(for: T.self)
        register(UINib(nibName: String(describing: viewClass), bundle: bundle), forHeaderFooterViewReuseIdentifier: String(describing: viewClass))
    }
    
    public func dequeueCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    public func dequeueSupplementaryView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            return T()
        }
        return view
    }
}


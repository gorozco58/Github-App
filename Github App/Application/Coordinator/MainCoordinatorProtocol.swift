
import UIKit

protocol MainCoordinatorProtocol {
    var baseController: UINavigationController { get }
    
    func performTransition(transition: MainTransition, completion: (() -> Void)?)
}

enum MainTransition {
    case showHome
    case showContributors(Repository)
}

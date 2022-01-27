
import UIKit

class MainCoordinator: MainCoordinatorProtocol {
    var baseController = UINavigationController()
    
    init() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    func performTransition(transition: MainTransition, completion: (() -> Void)?) {
        switch transition {
        case .showHome:
            let viewModel =  RepositoriesListViewModel()
            let homeViewController = RepositoriesListViewController(viewModel: viewModel, coordinator: self)
            let navigationController = UINavigationController(rootViewController: homeViewController)
            navigationController.navigationBar.isTranslucent = false
            baseController = navigationController
        case .showContributors(let repo):
            let viewModel = ContributorsViewModel(repository: repo)
            let viewController = ContributorsViewController(viewModel: viewModel, coordinator: self)
            baseController.pushViewController(viewController, animated: true)
        }
    }
}

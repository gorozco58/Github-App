//
//  RepositoriesListViewModel.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation
import RxSwift
import RxCocoa

enum RepositoriesListViewModelAction: Equatable {
    case reloadData
    case repositorySelected(Repository)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.reloadData, .reloadData):
            return true
        case (.repositorySelected, .repositorySelected):
            return true
        default:
            return false
        }
    }
}

protocol RepositoriesListViewModelProtocol: RepositoriesViewControllerDataSourceProvider {
    var onAction: Observable<RepositoriesListViewModelAction> { get }
    
    func getRepositories()
}

class RepositoriesListViewModel: RepositoriesListViewModelProtocol {
    private let onActionSubject = PublishSubject<RepositoriesListViewModelAction>()
    private let service: RepositoryService
    private let disposeBag = DisposeBag()
    private(set) var onAction: Observable<RepositoriesListViewModelAction>
    private(set) var repos: [Repository] = []
    
    init(service: RepositoryService = RepositoryServiceAdapter()) {
        self.onAction = onActionSubject.asObservable()
        self.service = service
    }
    
    func getRepositories() {
        service
            .getRepositoriesList()
            .map { [unowned self] repos in
                self.repos = repos
                return .reloadData
            }
            .bind(to: onActionSubject)
            .disposed(by: disposeBag)
    }
    
    func repositoriesViewControllerDidSelectRepository(_ repo: Repository) {
        onActionSubject.onNext(.repositorySelected(repo))
    }
}

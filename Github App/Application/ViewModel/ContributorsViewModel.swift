//
//  ContributorsViewModel.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation
import RxSwift
import RxCocoa

enum ContributorsViewModelAction {
    case reloadData
}

protocol ContributorsViewModelProtocol: ContributorsViewControllerDataSourceProvider {
    var onAction: Observable<ContributorsViewModelAction> { get }
    var title: String { get }
    
    func getContributors()
}

class ContributorsViewModel: ContributorsViewModelProtocol {
    private let onActionSubject = PublishSubject<ContributorsViewModelAction>()
    private let repository: Repository
    private let service: RepositoryService
    private let disposeBag = DisposeBag()
    private(set) var onAction: Observable<ContributorsViewModelAction>
    private(set) var contributors: [Contributor] = []
    
    var title: String {
        return repository.name
    }
    
    init(repository: Repository, service: RepositoryService = RepositoryServiceAdapter()) {
        self.onAction = onActionSubject.asObservable()
        self.repository = repository
        self.service = service
    }
    
    func getContributors() {
        service
            .getContributors(for: repository.name, with: repository.owner.login)
            .map { [unowned self] contributors in
                self.contributors = contributors
                return .reloadData
            }
            .bind(to: onActionSubject)
            .disposed(by: disposeBag)
    }
}


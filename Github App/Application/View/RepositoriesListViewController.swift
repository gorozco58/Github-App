//
//  RepositoriesListViewController.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import UIKit
import RxSwift

class RepositoriesListViewController: UIViewController {

    @IBOutlet private weak var reposTableView: UITableView!
    
    private let dataSource = RepositoriesViewControllerDataSource()
    private let viewModel: RepositoriesListViewModelProtocol
    private let coordinator: MainCoordinatorProtocol
    private let disposeBag = DisposeBag()
    
    init(viewModel: RepositoriesListViewModelProtocol, coordinator: MainCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: RepositoriesListViewController.self), bundle: nil)
        self.title = LocalizedString.repositoriesTitle.localized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
}

//MARK: - Private functions
private extension RepositoriesListViewController {
    
    func setupTableView() {
        dataSource.provider = viewModel
        reposTableView.registerCell(RepositoryCell.self)
        reposTableView.dataSource = dataSource
        reposTableView.delegate = dataSource
        reposTableView.rowHeight = UITableView.automaticDimension
        reposTableView.estimatedRowHeight = 100
    }
    
    func setupViewModel() {
        viewModel
            .onAction
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case .reloadData:
                    self.reposTableView.reloadData()
                case .repositorySelected(let repo):
                    self.coordinator.performTransition(transition: .showContributors(repo), completion: nil)
                }
            })
            .disposed(by: disposeBag)
        viewModel.getRepositories()
    }
}

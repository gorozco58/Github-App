//
//  ContributorsViewController.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import UIKit
import RxSwift

class ContributorsViewController: UIViewController {

    @IBOutlet private weak var contributorsTableView: UITableView!
    
    private let dataSource = ContributorsViewControllerDataSource()
    private let viewModel: ContributorsViewModelProtocol
    private let coordinator: MainCoordinatorProtocol
    private let disposeBag = DisposeBag()
    
    init(viewModel: ContributorsViewModelProtocol, coordinator: MainCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: String(describing: ContributorsViewController.self), bundle: nil)
        self.title = viewModel.title
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
private extension ContributorsViewController {
    
    func setupTableView() {
        dataSource.provider = viewModel
        contributorsTableView.registerCell(ContributorCell.self)
        contributorsTableView.dataSource = dataSource
    }
    
    func setupViewModel() {
        viewModel
            .onAction
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                switch $0 {
                case .reloadData:
                    self.contributorsTableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        viewModel.getContributors()
    }
}

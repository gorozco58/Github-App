//
//  RepositoriesViewModelTests.swift
//  Github AppTests
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import XCTest
import RxSwift
import RxTest
@testable import Github_App

class RepositoriesViewModelTests: XCTestCase {

    var service: RepositoriesMockService!
    var viewModel: RepositoriesListViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        service = RepositoriesMockService()
        viewModel = RepositoriesListViewModel(service: service)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        scheduler.start()
    }

    override func tearDownWithError() throws {
        service = nil
        viewModel = nil
        scheduler = nil
        disposeBag = nil
    }

    func test_reloadDataAction_whenGetRepositories_shouldBeSuccess() throws {
        service.expectedReponse = .success
        let observer = scheduler
            .createObserver(RepositoriesListViewModelAction.self)
        
        viewModel
            .onAction
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        viewModel.getRepositories()
        
        let action = observer.events.last?.value.element
        XCTAssertEqual(action, .reloadData)
    }
    
    func test_whenGetRepositories_shouldBeError() throws {
        service.expectedReponse = .error
        let observer = scheduler
            .createObserver(RepositoriesListViewModelAction.self)
        
        viewModel
            .onAction
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        viewModel.getRepositories()
        
        let action = observer.events.last?.value.element
        XCTAssertNil(action)
    }
    
    func test_repositories_whenGetRepositories_shouldBeSaved() throws {
        service.expectedReponse = .success
        viewModel.getRepositories()
        XCTAssertEqual(viewModel.repos.count, 30)
    }
    
    func test_repositories_whenGetRepositories_shouldBeEmpty() throws {
        service.expectedReponse = .error
        viewModel.getRepositories()
        XCTAssertEqual(viewModel.repos.count, 0)
    }
    
    func test_repositorySelected_whenSelectTableCell_shouldCallAction() {
        service.expectedReponse = .success
        let observer = scheduler
            .createObserver(RepositoriesListViewModelAction.self)
        
        viewModel
            .onAction
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        viewModel.getRepositories()
        
        let repository = viewModel.repos[0]
        viewModel.repositoriesViewControllerDidSelectRepository(repository)
        
        let action = observer.events.last?.value.element
        XCTAssertEqual(action, .repositorySelected(repository))
    }
}

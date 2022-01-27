//
//  ContributorsViewModelTests.swift
//  Github AppTests
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import XCTest
import RxSwift
import RxTest
@testable import Github_App

class ContributorsViewModelTests: XCTestCase {

    var service: RepositoriesMockService!
    var repository: Repository!
    var viewModel: ContributorsViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        service = RepositoriesMockService()
        repository = Repository(
            id: 1,
            name: "My Repository",
            description: "my repository description",
            owner: Owner(
                id: 1,
                login: "gorozco58",
                avatarURL: URL(string: "https://api.github.com/users/QuincyLarson")!
            )
        )
        viewModel = ContributorsViewModel(repository: repository, service: service)
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

    func test_reloadDataAction_whenGetContributors_shouldBeSuccess() throws {
        service.expectedReponse = .success
        let observer = scheduler
            .createObserver(ContributorsViewModelAction.self)
        
        viewModel
            .onAction
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        viewModel.getContributors()
        
        let action = observer.events.last?.value.element
        XCTAssertEqual(action, .reloadData)
    }
    
    func test_whenGetContributors_shouldBeError() throws {
        service.expectedReponse = .error
        let observer = scheduler
            .createObserver(ContributorsViewModelAction.self)
        
        viewModel
            .onAction
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        viewModel.getContributors()
        
        let action = observer.events.last?.value.element
        XCTAssertNil(action)
    }
    
    func test_contributors_whenGetContributors_shouldBeSaved() throws {
        service.expectedReponse = .success
        viewModel.getContributors()
        XCTAssertEqual(viewModel.contributors.count, 30)
    }
    
    func test_contributors_whenGetContributors_shouldBeEmpty() throws {
        service.expectedReponse = .error
        viewModel.getContributors()
        XCTAssertEqual(viewModel.contributors.count, 0)
    }
}

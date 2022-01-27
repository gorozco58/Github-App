//
//  RepositoriesMockService.swift
//  Github AppTests
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation
import RxSwift
@testable import Github_App

class RepositoriesMockService: RepositoryService {
    
    enum ResponseType {
        case success
        case error
    }
    
    var expectedReponse: ResponseType = .success
    
    func getRepositoriesList() -> Observable<[Repository]> {
        guard expectedReponse == .success else {
            return Observable.error(RxError.noElements)
        }
        
        return Observable<[Repository]>.create { observer in
            do {
                let data = try ResponseParser.dictionaryResponse(from: "repositories")
                let response: RepositoriesResponse = try JSONDecoder.model(with: data)
                observer.onNext(response.items)
            } catch {
                let e = error as! ParserError
                observer.onError(e)
            }
            return Disposables.create()
        }
    }
    
    func getContributors(for repoName: String, with ownerName: String) -> Observable<[Contributor]> {
        guard expectedReponse == .success else {
            return Observable.error(RxError.noElements)
        }
        
        return Observable<[Contributor]>.create { observer in
            do {
                let data = try ResponseParser.anyResponse(from: "contributors")
                let response: [Contributor] = try JSONDecoder.model(with: data)
                observer.onNext(response)
            } catch {
                let e = error as! ParserError
                observer.onError(e)
            }
            return Disposables.create()
        }
    }
}

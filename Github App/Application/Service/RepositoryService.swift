//
//  RepositoryService.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation
import RxSwift
import Alamofire

protocol RepositoryService {
    func getRepositoriesList() -> Observable<[Repository]>
    func getContributors(for repoName: String, with ownerName: String) -> Observable<[Contributor]>
}

struct RepositoryServiceAdapter: RepositoryService {
    
    func getRepositoriesList() -> Observable<[Repository]> {
        let parameters = ["q" : "stars:>0"]
        
        return Observable.create { observable in
            AF.request(Request.repositories, parameters: parameters)
                .log()
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let response: RepositoriesResponse = try JSONDecoder.model(with: data)
                            observable.onNext(response.items)
                        } catch {
                            observable.onError(error)
                        }
                    case .failure(let error):
                        observable.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func getContributors(for repoName: String, with ownerName: String) -> Observable<[Contributor]> {
        return Observable.create { observable in
            AF.request(Request.contributors(repoName: repoName, ownerName: ownerName))
                .log()
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let response: [Contributor] = try JSONDecoder.model(with: data)
                            observable.onNext(response)
                        } catch {
                            observable.onError(error)
                        }
                    case .failure(let error):
                        observable.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

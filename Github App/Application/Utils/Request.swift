
import Foundation
import Alamofire

enum Request: URLConvertible {
    
    case repositories
    case contributors(repoName: String, ownerName: String)
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        case .contributors(let repoName, let ownerName):
            return "/repos/\(ownerName)/\(repoName)/contributors"
        }
    }
    
    func asURL() -> URL {
        let endpoint = baseURL.appendingPathComponent(path)
        return endpoint
    }
}

public extension DataRequest {
    
    func log(_ fileName: String = #file, _ functionName: String = #function, _ lineNumber: Int = #line) -> DataRequest {
        responseJSON {
            switch $0.result {
            case .success(let response):
                Log.shared.info(response, fileName, functionName, lineNumber)
            case .failure:
                Log.shared.error($0.response, fileName, functionName, lineNumber)
            }
        }
        return self
    }
}

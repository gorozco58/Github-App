import Foundation

enum ParserError: Error {
    case fileName(String)
    case data
    case jsonParsing
    
    var description: String {
        switch self {
        case .fileName(let name):
            return "JSON file with name \(name) does not exists"
        case .data:
            return "Error trying to parse json data"
        case .jsonParsing:
            return "Error parsing the JSON"
        }
    }
}

public class ResponseParser {
    
    static func dictionaryResponse(from fileName: String) throws -> [String : Any?] {
        guard let path = Bundle(for: self).path(forResource: fileName, ofType: "json") else {
            throw ParserError.fileName(fileName)
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            throw ParserError.data
        }
        guard let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String : Any?] else {
            throw ParserError.jsonParsing
        }
        
        return jsonResult
    }
    
    static func anyResponse(from fileName: String) throws -> Any {
        guard let path = Bundle(for: self).path(forResource: fileName, ofType: "json") else {
            throw ParserError.fileName(fileName)
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            throw ParserError.data
        }
        guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
            throw ParserError.jsonParsing
        }
        
        return jsonResult
    }
}


import Foundation

public extension JSONDecoder {
    
    static func model<T: Decodable>(with jsonDictionary: [AnyHashable: Any]) throws -> T {
        let dataJson = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
        return try JSONDecoder().decode(T.self, from: dataJson)
    }
    
    static func model<T: Decodable>(with json: Any) throws -> T {
        let dataJson = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return try JSONDecoder().decode(T.self, from: dataJson)
    }
}

// MARK: - This extension is used to serialize the Codable entities to dictionaries.
extension Encodable {
    public var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

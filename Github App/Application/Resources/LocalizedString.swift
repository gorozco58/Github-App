//
//  LocalizedString.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import Foundation

public enum LocalizedString: String {
    case author
    case repositoriesTitle
    case contributions

    public var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
    
    public func localizeWithFormat(arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}

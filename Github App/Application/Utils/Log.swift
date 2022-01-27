
import UIKit

public enum LogLevel: Int {
    
    case error = 0
    case warning
    case info
    
    public func symbol() -> String {
        switch self {
        case .error:
            return "❌"
        case .warning:
            return "⚠️"
        case .info:
            return "✅"
        }
    }
    
    public func name() -> String {
        switch self {
        case .error:
            return "Error"
        case .warning:
            return "Warning"
        case .info:
            return "Info"
        }
    }
}

public class Log {
    
    public static let shared = Log()
    fileprivate var level: LogLevel = .info
    
    public func error(_ item: @autoclosure () -> Any?, _ fileName: String = #file, _ functionName: String = #function, _ lineNumber: Int = #line) {
        printLog(.error, fileName, functionName, lineNumber, item)
    }
    
    public func warning(_ item: @autoclosure () -> Any?, _ fileName: String = #file, _ functionName: String = #function, _ lineNumber: Int = #line) {
        printLog(.warning, fileName, functionName, lineNumber, item)
    }
    
    public func info(_ item: @autoclosure () -> Any?, _ fileName: String = #file, _ functionName: String = #function, _ lineNumber: Int = #line) {
        printLog(.info, fileName, functionName, lineNumber, item)
    }
    
    fileprivate func printLog(_ logLevel: LogLevel,
                              _ fileName: String = #file,
                              _ functionName: String = #function,
                              _ lineNumber: Int = #line,
                              _ item: () -> Any?) {
        
        guard let itemToLog = item() else {
            return
        }
        var file: String = fileName.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        if let lastPath: String = NSURL(string: fileName)?.lastPathComponent {
            file = lastPath
        }
        var function: String = functionName
        if let leftParenthesisPosition = functionName.firstIndex(of: "(") {
            function = String(functionName[..<leftParenthesisPosition])
        }
        function.append("()")
        let time: String = self.getCurrentTime()
        let header: String = "\n\(logLevel.symbol()) [\(logLevel.name())] [\(file) → \(function) → Line \(lineNumber)] [\(time)]"
        let finalContent: String = "\(header)\n\(itemToLog)"
        if logLevel.rawValue <= self.level.rawValue {
            print(finalContent)
        }
    }
    
    fileprivate func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let result: String = formatter.string(from: Date())
        return result
    }
}

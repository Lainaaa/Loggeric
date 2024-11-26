import os
import Foundation

/// Protocol for the logger
public protocol LoggericProtocol {
    /// Logs a message
    /// - Parameters:
    ///   - level: Log level.
    ///   - message: Message to log.
    ///   - file: File name (default).
    ///   - function: Function name (default).
    ///   - line: Line number (default).
    func log(level: LogLevel, message: String, file: String, function: String, line: Int)
}

/// Log levels with `os_log` support
public enum LogLevel: String {
    /// Default log level
    case `default` = "default"
    /// Debug log level
    case debug = "debug"
    /// Information log level
    case info = "info"
    /// Error log level
    case error = "error"
    /// Critical error log level
    case fault = "fault"
    
    var osLogType: OSLogType {
        switch self {
        case .default: return .default
        case .debug: return .debug
        case .info: return .info
        case .error: return .error
        case .fault: return .fault
        }
    }
    
    var heart: String {
        switch self {
        case .default: return "💚"
        case .debug: return "🖤"
        case .info: return "💛"
        case .error: return "❤️"
        case .fault: return "❤️‍🔥"
        }
    }
}

/// Implementation of the logger based on os_log
public class Loggeric: LoggericProtocol {
    private let logger: OSLog
    private let module: String?
    
    
    public init(subsystem: String? = nil, module: String? = nil) {
        self.logger = OSLog(subsystem: subsystem ?? "com.Loggeric" , category: module ?? "Logs")
        self.module = module
    }
    
    public func log(level: LogLevel,
                    message: String,
                    file: String = #fileID,
                    function: String = #function,
                    line: Int = #line) {
        let formattedMessage = formatMessage(level: level, message: message, file: file, function: function, line: line)
        os_log("%@", log: logger, type: level.osLogType, formattedMessage as NSString)
    }
    
    // Debug log level
    public func `default`(_ message: String,
                      file: String = #fileID,
                      function: String = #function,
                      line: Int = #line) {
        log(level: .default, message: message, file: file, function: function, line: line)
    }
    
    // Debug log level
    public func debug(_ message: String,
                      file: String = #fileID,
                      function: String = #function,
                      line: Int = #line) {
        log(level: .debug, message: message, file: file, function: function, line: line)
    }
    
    // Info log level
    public func info(_ message: String,
                     file: String = #fileID,
                     function: String = #function,
                     line: Int = #line) {
        log(level: .info, message: message, file: file, function: function, line: line)
    }
    
    // Error log level
    public func error(_ message: String,
                      file: String = #fileID,
                      function: String = #function,
                      line: Int = #line) {
        log(level: .error, message: message, file: file, function: function, line: line)
    }
    
    // Fault log level
    public func fault(_ message: String,
                      file: String = #fileID,
                      function: String = #function,
                      line: Int = #line) {
        log(level: .fault, message: message, file: file, function: function, line: line)
    }
    
    private func formatMessage(level: LogLevel,
                               message: String,
                               file: String,
                               function: String,
                               line: Int) -> String {
        let time = timestamp()
        let heart = level.heart
        let header = "\(heart)[\(level.rawValue.uppercased())] \(time)"
        let modulePart = module != nil ? "\(module!) | " : ""
        let location = "\(modulePart)\(file) | \(function) | line: \(line)"
        return """
        \(header)
        \(location)
        \(message)
        """
    }
    
    private func timestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
}

import os
import Foundation

/// Протокол для логгера
public protocol LoggericProtocol {
    /// Логирование сообщения
    /// - Parameters:
    ///   - level: Уровень логирования.
    ///   - message: Сообщение.
    ///   - file: Имя файла (по умолчанию).
    ///   - function: Имя функции (по умолчанию).
    ///   - line: Номер строки (по умолчанию).
    func log(level: LogLevel, message: String, file: String, function: String, line: Int)
}

/// Уровни логирования с поддержкой `os_log`
public enum LogLevel: String {
    /// Default
    case `default` = "default"
    /// For debug purpose
    case debug = "debug"
    /// For something where you should pay attention but is it now critical
    case info = "info"
    /// For errors
    case error = "error"
    /// For critical errors
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

/// Реализация логгера на основе os_log
public class Loggeric: LoggericProtocol {
    private let logger: OSLog
    private let module: String
    
    public init(subsystem: String, module: String) {
        self.logger = OSLog(subsystem: subsystem, category: module)
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
    
    private func formatMessage(level: LogLevel,
                               message: String,
                               file: String,
                               function: String,
                               line: Int) -> String {
        let time = timestamp()
        let heart = level.heart
        let header = "\(heart)[\(level.rawValue.uppercased())] \(time)"
        let location = "\(module) | \(file) | \(function) | line: \(line)"
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

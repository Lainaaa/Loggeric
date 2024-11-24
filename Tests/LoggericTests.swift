//
//  File.swift
//  Loggeric
//
//  Created by Dmitrij Meidus on 24.11.24.
//

import Testing
@testable import Loggeric

public class MockLogger: LoggericProtocol {
    public var capturedLogs: [(level: LogLevel, message: String, file: String, function: String, line: Int)] = []
    
    public init() {}
    
    public func log(level: LogLevel,
                    message: String,
                    file: String = #fileID,
                    function: String = #function,
                    line: Int = #line) {
        capturedLogs.append((level, message, file, function, line))
    }
}


/// To run this use swift test
@Test func testLogger() async throws {
    // Создаём мок-логгер
    let mockLogger = MockLogger()
    let logger = Loggeric(subsystem: "com.example", module: "TestModule")
    
    // Логируем тестовое сообщение
    mockLogger.log(level: .info, message: "Test Info Log", file: "TestFile.swift", function: "testFunction()", line: 42)
    // Проверяем, что сообщение было захвачено
    #expect(mockLogger.capturedLogs.count == 1)
    let capturedLog = mockLogger.capturedLogs.first
    #expect(capturedLog?.level == .info)
    #expect(capturedLog?.message == "Test Info Log")
    #expect(capturedLog?.file == "TestFile.swift")
    #expect(capturedLog?.function == "testFunction()")
    #expect(capturedLog?.line == 42)
}

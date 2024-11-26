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

/// Testing the `default` method
@Test func testDefaultLog() async throws {
    let mockLogger = MockLogger()
    mockLogger.log(level: .default, message: "Default message", file: "TestFile.swift", function: "testFunction()", line: 60)
    
    #expect(mockLogger.capturedLogs.count == 1)
    let capturedLog = mockLogger.capturedLogs.first
    #expect(capturedLog?.level == .default)
    #expect(capturedLog?.message == "Default message")
    #expect(capturedLog?.file == "TestFile.swift")
    #expect(capturedLog?.function == "testFunction()")
    #expect(capturedLog?.line == 60)
}

/// Testing the `debug` method
@Test func testDebugLog() async throws {
    let mockLogger = MockLogger()
    mockLogger.log(level: .debug, message: "Debug message", file: "TestFile.swift", function: "testFunction()", line: 10)
    
    #expect(mockLogger.capturedLogs.count == 1)
    let capturedLog = mockLogger.capturedLogs.first
    #expect(capturedLog?.level == .debug)
    #expect(capturedLog?.message == "Debug message")
    #expect(capturedLog?.file == "TestFile.swift")
    #expect(capturedLog?.function == "testFunction()")
    #expect(capturedLog?.line == 10)
}

/// Testing the `info` method
@Test func testInfoLog() async throws {
    let mockLogger = MockLogger()
    mockLogger.log(level: .info, message: "Info message", file: "TestFile.swift", function: "testFunction()", line: 20)
    
    #expect(mockLogger.capturedLogs.count == 1)
    let capturedLog = mockLogger.capturedLogs.first
    #expect(capturedLog?.level == .info)
    #expect(capturedLog?.message == "Info message")
    #expect(capturedLog?.file == "TestFile.swift")
    #expect(capturedLog?.function == "testFunction()")
    #expect(capturedLog?.line == 20)
}

/// Testing the `error` method
@Test func testErrorLog() async throws {
    let mockLogger = MockLogger()
    mockLogger.log(level: .error, message: "Error message", file: "TestFile.swift", function: "testFunction()", line: 30)
    
    #expect(mockLogger.capturedLogs.count == 1)
    let capturedLog = mockLogger.capturedLogs.first
    #expect(capturedLog?.level == .error)
    #expect(capturedLog?.message == "Error message")
    #expect(capturedLog?.file == "TestFile.swift")
    #expect(capturedLog?.function == "testFunction()")
    #expect(capturedLog?.line == 30)
}

/// Testing the `fault` method
@Test func testFaultLog() async throws {
    let mockLogger = MockLogger()
    mockLogger.log(level: .fault, message: "Fault message", file: "TestFile.swift", function: "testFunction()", line: 40)
    
    #expect(mockLogger.capturedLogs.count == 1)
    let capturedLog = mockLogger.capturedLogs.first
    #expect(capturedLog?.level == .fault)
    #expect(capturedLog?.message == "Fault message")
    #expect(capturedLog?.file == "TestFile.swift")
    #expect(capturedLog?.function == "testFunction()")
    #expect(capturedLog?.line == 40)
}

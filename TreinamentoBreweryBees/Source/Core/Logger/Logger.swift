//
//  Logger.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 02/05/24.
//

import OSLog

enum LogLevel {
    case debug
    case info
    case error
    case fault
    
    var osLogType: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .error:
            return .error
        case .fault:
            return .fault
        }
    }
}

class Logger {
    private let log: OSLog
    private let bundleIdentifier: String
    
    init(category: String) {
        self.bundleIdentifier = BreweryBees().bundle.bundleIdentifier ?? Bundle.main.bundleIdentifier!
        self.log = OSLog(subsystem: bundleIdentifier, category: category)
    }
    
    func log(message: String, level: LogLevel = .debug, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        let file = fileName.components(separatedBy: "/").last ?? "UnknownFile"
        let logMessage = "\(file).\(functionName):\(lineNumber) - \(message)"
        os_log("%{public}@", log: log, type: level.osLogType, logMessage)
    }
}

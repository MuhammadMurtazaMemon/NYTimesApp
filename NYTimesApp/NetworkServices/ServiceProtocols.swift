//
//  ServiceProtocols.swift
//  NYTimesApp
//
//  Created by Murtaza on 19/08/2025.
//

import Foundation

//MARK: - PropertyListProtocol
public protocol PropertyListValue: Encodable {
    var description: String { get }
}

//MARK: - Extension for types that are acceptable as PropertyList
extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}
extension Decimal: PropertyListValue {}
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

//MARK: - NETWORKING

//MARK: - Network Error ENUMS
public enum NetworkError: Error {
    case ErrorMessage(String)
    case ResponseDataIsNil
    case ResponseDecodingFailed(with: String)
}

//MARK: - Supported REST Methods
enum NetworkMethod: String {
    case POST
    case GET
    case DELETE
    case PUT
    case PATCH
}

//MARK: - Network Request Protocol
protocol NetworkRequestable {
    var method: NetworkMethod { get }
    var url: URL { get }
    var parameters: [String: PropertyListValue] { get }
}

//MARK: - Protocol for Netwroking
protocol NetworkService {
    func performOperation<R: Decodable>(on request: NetworkRequestable, _ handler: @escaping((Result<R, NetworkError>) -> Void))
}

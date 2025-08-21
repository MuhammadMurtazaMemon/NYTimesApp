//
//  URLNetworkService.swift
//  NYTimesApp
//
//  Created by Murtaza on 19/08/2025.
//


import Foundation

final class URLNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func performOperation<R: Decodable>(on request: NetworkRequestable, _ handler: @escaping ((Result<R, NetworkError>) -> Void)) {
        switch request.method {
        case .GET:
            performGetOperation(url: request.url, parameteres: request.parameters, handler)
        case .POST:
            performPostOperation(url: request.url, parameters: request.parameters, handler)
        case .PUT:
            performPutOperation(url: request.url, parameters: request.parameters, handler)
        case .DELETE:
            performDeleteOperation(url: request.url, handler)
        case .PATCH:
            performPatchOperation(url: request.url, parameters: request.parameters, handler)
        }
    }
    
    private func performGetOperation<R: Decodable>(url: URL, parameteres: [String: PropertyListValue], _ handler: @escaping((Result<R, NetworkError>) -> Void)) {
        var components = URLComponents(string: url.absoluteString)!
        var queryItem = components.queryItems ?? []
        queryItem.append(contentsOf: parameteres.map { URLQueryItem(name: $0.key, value: $0.value.description) })
        components.queryItems = queryItem
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 120
        setHeaders(on: &request)
        perform(request, handler)
    }
    
    private func performPostOperation<R: Decodable>(url: URL, parameters: [String: PropertyListValue], _ handler: @escaping((Result<R, NetworkError>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 120
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        setHeaders(on: &request)
        perform(request, handler)
    }
    
    private func performPutOperation<R: Decodable>(url: URL, parameters: [String: PropertyListValue], _ handler: @escaping((Result<R, NetworkError>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.timeoutInterval = 120
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        setHeaders(on: &request)
        perform(request, handler)
    }
    
    private func performPatchOperation<R: Decodable>(url: URL, parameters: [String: PropertyListValue], _ handler: @escaping((Result<R, NetworkError>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.timeoutInterval = 120
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        setHeaders(on: &request)
        perform(request, handler)
    }
    
    private func performDeleteOperation<R: Decodable>(url: URL, _ handler: @escaping((Result<R, NetworkError>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.timeoutInterval = 120
        setHeaders(on: &request)
        perform(request, handler)
    }
    
    private func setHeaders(on request: inout URLRequest) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    private func perform<R: Decodable>(_ request: URLRequest, _ handler: @escaping((Result<R, NetworkError>) -> Void)) {
#if DEBUG
        print("====================Request: \(request)======================")
#endif
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                handler(self.computeResponse(data, response, error))
            }
        }.resume()
    }
    
    private func computeResponse<R: Decodable>(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<R, NetworkError> {
#if DEBUG
        print("==Response Code: \(String(describing: (response as? HTTPURLResponse)?.statusCode)) || Data: ==\(String(describing: String(data: data ?? Data(), encoding: .utf8)))==")
#endif
        
        if let error = error {
#if DEBUG
            print("URL SESSION ERROR: \(error)")
#endif
            return .failure(.ErrorMessage(error.localizedDescription))
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            if let data = data, let decodedError = try? JSONDecoder().decode(ErrorResponse.self, from: data), let message = decodedError.fault?.faultstring {
                return .failure(.ErrorMessage(message))
            }
            else {
                return .failure(.ErrorMessage("Oopss....Something went wrong."))
            }
        }
        guard let data = data else {
            return .failure(.ResponseDataIsNil)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(R.self, from: data)
            return .success(decodedResponse)
        } catch {
#if DEBUG
            print("Network Response Decoding error: \(error)")
#endif
            return .failure(.ResponseDecodingFailed(with: error.localizedDescription))
        }
    }
}


public struct ErrorResponse: Decodable {
    let fault: ErrorDetailResponse?
}

public struct ErrorDetailResponse: Decodable {
    let faultstring: String?
}

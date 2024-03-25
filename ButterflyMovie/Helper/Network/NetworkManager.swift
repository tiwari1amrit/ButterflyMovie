//
//  NetworkManager.swift
//  Inks
//
//  Created by Amrit Tiwari on 17/1/2023.
//

import Foundation
import UIKit

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

struct StatusCode {
    
    static let success: Int = 200
    static let signUpSuccess: Int = 201 // success on sign up
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private func getRequest(_ url: URL,
                            withParameter parameter: [String: String]? = nil,
                            headers: [String: String]? = nil,
                            method: HttpMethod = .get) -> URLRequest?{
        
        print(url)
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            //            completion(.failure(.invalidEndpoint))
            return nil
        }
        
        
        var queryItems = [URLQueryItem(name: "api_key", value: Urls.apiKey)]
        if let params = parameter {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            //            completion(.failure(.invalidEndpoint))
            return nil
        }
        
        var request: URLRequest = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        return request
        
    }
    
    // Fetch data from specified url
    func fetchData<T: Codable>(_ url: URL,
                               withParameter parameter: [String: String]? = nil,
                               headers: [String: String]? = nil,
                               method: HttpMethod = .get,
                               withCompletion completion: @escaping (T) -> Void,
                               withCompletionWithError errors: @escaping (String) -> Void) {
        
        guard let request = self.getRequest(
            url, withParameter: parameter, headers: headers, method: method) else {
            return
        }
        self.checkInternet{ error in
            errors(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    errors(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    errors(error?.localizedDescription ?? "Failed to fetch courses")
                    return
                }
                
                self.printOutResponse(data: data, response: response)
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(decodedData)
                } catch {
                    errors("Error decoding data: \(error)")
                }
                
            }
        }.resume()
    }
    
    // MARK: Print Response from API
    private func printOutResponse(data: Data, response: URLResponse?) {
        // for printing response
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode
        print("Status Code =>\(String(describing: statusCode))")
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } catch {
            print(error)
        }
    }
    
    // MARK: Check Internet
    private func checkInternet(withCompletionError errors: @escaping (String) -> Void) {
        
        // show alert for no net
        do {
            let googleTest = try Reachability(hostname: "www.google.com")
            
            guard let result = googleTest?.isReachable, result else {
                
                let errorMessage = Errors.Apis.noInternet
                errors(errorMessage)
                return
            }
        } catch {
            print(error)
            errors(error.localizedDescription)
        }
        
    }
}

//
//  APIRequest.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import Foundation

final class APIRequest {
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint: Endpoint
    
    private let pathComponents: [String]
    
    private let queryParameters: [URLQueryItem]
    
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        ///Si hay pathComponents
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        ///Si hay query parameters
        if !queryParameters.isEmpty {
            string += "?"
            /// name=value&name=value
            let argumentString = queryParameters.compactMap({
                /// propertie is optional, unwrapped
                
                guard let value = $0.value else {return nil}
                
                return "\($0.name)=\(value)"
                
            }).joined(separator: "&")
            
            ///Append to the end of the string
            string += argumentString
        }
        
        return string
    }
    
//    public var url: URL? {
//        return URL(string: urlString)
//    }
    
    public var url: String? {
        return urlString
    }
    
    public let httpMethod = "GET"
    
    // MARK: - Public
    public init(endpoint: Endpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
   
}

extension APIRequest{
    static let listAllCharactersURL = APIRequest(endpoint: .character).url

}

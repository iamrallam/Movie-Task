//
//  EndPoint.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import Foundation



public enum MovieApi {
    case newMovies(page:Int)
}
public enum MovieDetailsApi {
    case getMovieDetail(movieId:Int)
}


extension MovieApi: EndPointProtocol {
    
    var baseURL: URL {
        guard let url = URL(string: Path.base_Url.absolutePath) else { fatalError("Theries something wrong on url path")}
        return url
    }
    
    var path: String {
        switch self {
        case .newMovies:
            return "now_playing"

        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key":Path.API_KEY.absolutePath])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
extension MovieDetailsApi: EndPointProtocol {
    
    var baseURL: URL {
        guard let url = URL(string: Path.base_Url.absolutePath) else { fatalError("Theries something wrong on url path")}
        return url
    }
    
    var path: String {
        switch self {
        case .getMovieDetail(movieId: let movieId):
            return "\(movieId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getMovieDetail(movieId: _):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":Path.API_KEY.absolutePath])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}

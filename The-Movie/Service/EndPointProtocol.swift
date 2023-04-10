//
//  EndPointProtocol.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import Foundation
protocol EndPointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

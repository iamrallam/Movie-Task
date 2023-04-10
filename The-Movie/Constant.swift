//
//  Constant.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import Foundation

enum Path :String{
    case base_Url
    case image_Url
    case API_KEY
    var absolutePath: String {
        switch self {
        case .base_Url:
            return "https://api.themoviedb.org/3/movie/"
        case .image_Url:
            return "https://image.tmdb.org/t/p/w1280"
        case .API_KEY:
            return "c9856d0cb57c3f14bf75bdc6c063b8f3"
            
        }
    }
}

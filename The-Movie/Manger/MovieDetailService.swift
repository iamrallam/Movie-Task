//
//  MovieDetailService.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import Foundation
struct MovieDetailService {
    
    let router = Router<MovieDetailsApi>()
    func getMovieDetail(movieId: Int, completion: @escaping (_ movie: Movie?,_ error: String?)->()){
        
        router.request(.getMovieDetail(movieId: movieId)) { data, response, error in
            if error != nil {
                completion(nil, "Theres Something Wrong.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = MovieService.self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(Movie.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
            
        }
    }
}

//
//  MovieDetailViewModel.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 10/04/2023.
//

import Foundation

struct MovieDetailViewModel {
    
    var service:MovieDetailService?
    var handleError : ((ErrorResult?) -> Void)?

    init(service :MovieDetailService = MovieDetailService()) {
        self.service = service
    }
    
    func fetchMovieDetails(withId:Int ,completion: @escaping (_ movie: Movie?)->()){
        guard service != nil else {
            handleError?(ErrorResult.custom(string: "Missing service"))
            return
        }
        service?.getMovieDetail(movieId: withId, completion: { movie, error in
            if (error != nil) {
                self.handleError?(ErrorResult.custom(string: error ?? ""))
            }
            else{
                DispatchQueue.main.async {
                    if let item = movie{
                        completion(item)
                    }else{
                        self.handleError?(ErrorResult.custom(string: "Missing service"))
                    }
                }
            }
        })
    }
}

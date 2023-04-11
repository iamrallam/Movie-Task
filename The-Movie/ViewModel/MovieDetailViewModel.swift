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
    weak var dataSource : GenericData<Movie>?

    init(service :MovieDetailService = MovieDetailService(), dataSource : GenericData<Movie>?) {
        self.service = service
        self.dataSource = dataSource
    }
    
    func fetchMovieDetails(withId:Int){
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
                        self.dataSource?.dataModel.value = [item]
                    }else{
                        self.handleError?(ErrorResult.custom(string: "Missing service"))
                    }
                }
            }
        })
    }
}

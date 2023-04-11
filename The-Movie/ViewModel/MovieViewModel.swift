//
//  MovieViewModel.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import Foundation
enum ErrorResult: Error {
    case custom(string: String)
}

struct MovieViewModel {
    
    var service:MovieService?
    weak var dataSource : GenericDataSource<Movie>?
    var handleError : ((ErrorResult?) -> Void)?
    
    
    init(service :MovieService = MovieService(),serviceDetail :MovieDetailService = MovieDetailService(),dataSource : GenericDataSource<Movie>?) {
        self.service = service
        self.dataSource = dataSource
    }
    func fetchAllMovies() {
        guard let service = service else {
            handleError?(ErrorResult.custom(string: "Missing service"))
            return
        }
        service.getNewMovies(page: 1) { movies, error in
            if (error != nil) {
                self.handleError?(ErrorResult.custom(string: error ?? ""))
            }
            else{
                DispatchQueue.main.async {
                    if let items = movies{
                        self.sortArrByDate(movieArr: items,orderType: .orderedDescending)
                    }else{
                        self.handleError?(ErrorResult.custom(string: "Missing service"))
                    }
                }
            }
            
        }
    }
    
    func sortArrByDate(movieArr:[Movie],orderType:ComparisonResult){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dataSource?.dataHandler.value = movieArr.sorted(by: { dateFormatter.date(from:$0.releaseDate)?.compare(dateFormatter.date(from:$1.releaseDate)!) == orderType })
    }
}
extension String {
    func formateDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: newDate!)
    }
}

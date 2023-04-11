//
//  DetaislVC.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//


import UIKit
class DetailScreenUIModel : GenericData<Movie>{
}
class GenericData<T> : NSObject {
    var dynamicHandler: DataHandler<Any> = DataHandler(Any.self)
}

class DetailsVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    var movieId : Int?
    let detailUIModel = DetailScreenUIModel()
    
    
    lazy var viewModel : MovieDetailViewModel = {
        let viewModel = MovieDetailViewModel(dataSource: detailUIModel)
        return viewModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let id = movieId{
            viewModel.fetchMovieDetails(withId: id)
            self.detailUIModel.dynamicHandler.addObserver(self) { [weak self] _ in
                if let dataModel = self?.detailUIModel.dynamicHandler.value as? Movie{                self?.setupWithModel(withModel: dataModel)}
            }
        }
    }
    
    func setupWithModel(withModel:Movie) {
        lblTitle.text = withModel.title
        lblDesc.text = withModel.overview
        lblReleaseDate.text = withModel.releaseDate.formateDate()
        img.kf.setImage(with: URL(string: "\(Path.image_Url.absolutePath)\(withModel.posterPath)"))
    }
}



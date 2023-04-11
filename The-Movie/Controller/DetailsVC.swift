//
//  DetaislVC.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//


import UIKit
class DetailArr : GenericData<Movie>{
}
class GenericData<T> : NSObject {
    var dataModel: DynamicArrHandler<[T]> = DynamicArrHandler([])

}

class DetailsVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    var movieId : Int?
    let dataSource = DetailArr()
    

    lazy var viewModel : MovieDetailViewModel = {
        let viewModel = MovieDetailViewModel(dataSource: dataSource)
        return viewModel
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let id = movieId{
            viewModel.fetchMovieDetails(withId: id)
            self.dataSource.dataModel.addAndNotify(observer: self) { [weak self] _ in
                if self!.dataSource.dataModel.value.count > 0{ self!.setupWithModel() }
                }
        }
    }

    func setupWithModel() {
        let dataModel = dataSource.dataModel.value[0]
        lblTitle.text = dataModel.title
        lblDesc.text = dataModel.overview
        lblReleaseDate.text = dataModel.releaseDate.formateDate()
        img.kf.setImage(with: URL(string: "\(Path.image_Url.absolutePath)\(dataModel.posterPath)"))
    }
}



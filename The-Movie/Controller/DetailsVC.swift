//
//  DetaislVC.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//


import UIKit
class DetailsVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    var movieId : Int?
    lazy var viewModel : MovieDetailViewModel = {
        let viewModel = MovieDetailViewModel()
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let id = movieId{
            viewModel.fetchMovieDetails(withId: id) { movie in
                self.setupWithModel(model: movie!)
            }
        }
    }

    func setupWithModel(model:Movie) {
        lblTitle.text = model.title
        lblDesc.text = model.overview
        lblReleaseDate.text = model.releaseDate.formateDate()
        img.kf.setImage(with: URL(string: "\(Path.image_Url.absolutePath)\(model.posterPath)"))
    }
}

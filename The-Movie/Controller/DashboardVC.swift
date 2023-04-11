//
//  ViewController.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = MoviesTableDataSource()
    lazy var viewModel : MovieViewModel = {
        let viewModel = MovieViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        setupTableView()
        viewModel.handleError = { [weak self] error in
            let controller = UIAlertController(title: "Error", message: "Theres Something Wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        self.viewModel.fetchAllMovies()
    }
    func setupTableView() {
        self.tableView.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self.dataSource
        self.tableView.estimatedRowHeight = 130
        self.dataSource.dataHandler.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
}

extension DashboardVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard.loadFromMain(ControllersName.detailsViewController.rawValue) as? DetailsVC
        let model = dataSource.dataHandler.value[indexPath.row]
        detailVC?.movieId = model.id
        self.navigationController?.pushViewController(detailVC!, animated: true)
        
    }
}

class GenericDataSource<T> : NSObject {
    var dataHandler: DataHandler<[T]> = DataHandler([])
}

class MoviesTableDataSource : GenericDataSource<Movie>, UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataHandler.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.setupWithModel(model: dataHandler.value[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


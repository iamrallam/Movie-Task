//
//  MovieTableViewCell.swift
//  The-Movie
//
//  Created by Amr Mohamed Allam on 09/04/2023.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func setupWithModel(model:Movie) {
        lblTitle.text = model.title
        lblReleaseDate.text = model.releaseDate.formateDate()
        img.kf.setImage(with: URL(string: "\(Path.image_Url.absolutePath)\(model.posterPath)"))
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }

}

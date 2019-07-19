//
//  MovieTableViewCell.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblImdbID: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    var vm: MovieTableViewCellVM! {
        didSet {
            fillUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillUI() {
        lblTitle.text = "Title: " + vm.title
        lblImdbID.text = "IMDB ID: " + vm.imdbID
        lblYear.text = "Year: " + vm.year
        lblType.text = "Type: " + vm.type
    }
}

struct MovieTableViewCellVM {
    var posterImageName: String
    var title: String
    var imdbID: String
    var year: String
    var type: String
    
    init(movie: Movie) {
        posterImageName = movie.poster
        title = movie.title
        imdbID = movie.imdbID
        year = "\(movie.year)"
        type = movie.type
    }
}

//
//  MoviesViewController.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var vm: MoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.tableFooterView = UIView(frame: CGRect.zero)
        displayList()
    }
    
    private func displayList() {
        guard let errorMsg = vm.errorMessage else {
            let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
            moviesTableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
            moviesTableView.dataSource = self
            return
        }
        setErrorLabel(errorMsg: errorMsg)
    }
    
    private func setErrorLabel(errorMsg: String) {
        let label = UILabel()
        label.text = errorMsg
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.frame = CGRect(x:0,y:0,width:label.intrinsicContentSize.width,height:label.intrinsicContentSize.width)
        moviesTableView.backgroundView = label
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.vm = MovieTableViewCellVM(movie: vm.movies[indexPath.row])
        return cell
    }
}

struct MoviesViewModel {
    var movies: [Movie]
    var errorMessage: String?
}

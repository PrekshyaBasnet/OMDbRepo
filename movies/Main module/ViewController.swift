//
//  ViewController.swift
//  movies
//
//  Created by Prekshya Admin on 19/7/19.
//  Copyright © 2019 Prekshya Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var txtApiKey: UITextField!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var txtHttpMethod: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    var vm: ViewModel! {
        didSet {
            fillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSend()
        initializeFields()
        fillUI()
        activityIndicator.isHidden = true
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        view.endEditing(true)
        guard let url = txtUrl.text, !url.isEmpty,
            let apiKey = txtApiKey.text, !apiKey.isEmpty,
            let search = txtSearch.text, !search.isEmpty else {
                self.showAlert(withTitle: "Alert", message: "Please enter missing fields!", cancelTitle: "Okay") {}
                return
        }
        vm.url = url
        vm.apiKey = apiKey
        vm.searchKey = search
        requestMovies()
    }
    
    private func hideActivitiyIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    private func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func toggleBtnSend() {
        btnSend.isEnabled = !btnSend.isEnabled
    }
    
    private func requestMovies() {
        showActivityIndicator()
        toggleBtnSend()
        vm.requestMovies() { [weak self] (movies, errorMsg) in
            self?.hideActivitiyIndicator()
            self?.toggleBtnSend()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController
            guard let msg = errorMsg else {
                guard movies.count > 0 else {
                    self?.showAlert(withTitle: "Alert", message: "No data found!", cancelTitle: "Okay") {}
                    return
                }
                vc?.vm = self?.vm.getMovieVM(movies: movies)
                self?.pushVC(vc: vc!)
                return
            }
            vc?.vm = self?.vm.getMovieVM(movies: [])
            vc?.vm.errorMessage = msg
            self?.pushVC(vc: vc!)
            return
        }
    }
    
    private func initializeFields() {
        let omdbApi = OMDBApi(decoder: JsonDecoder())
        vm = ViewModel(omdbApi: omdbApi)
        vm.url = "http://www.omdbapi.com/"
        vm.apiKey = "ae9a18c6"
        vm.headers = nil
        vm.searchKey = "Star Wars"
        vm.httpMethod = "GET"
    }
    
    private func configureSend() {
        btnSend.layer.cornerRadius = 10
        btnSend.clipsToBounds = true
    }
    
    func fillUI() {
        txtUrl.text = vm.url
        txtApiKey.text = vm.apiKey
        txtSearch.text = vm.searchKey
        txtHttpMethod.text = vm.httpMethod
    }
}

//
//  DashboardViewController.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 01/05/22.
//

import UIKit

class DashboardViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var dashboardMoviesTableView: UITableView!
    var apiService = APIService()
    private var viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashboardMoviesTableView.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier )
        dashboardMoviesTableView.delegate = self
        dashboardMoviesTableView.dataSource = self
        
        self.retrieveData(preferences: "top_rated", page: 1, language: "en")
        loadBar()
    }

    @IBAction func selectCategoryPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Category", message: "Please Select an Category", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Popular", style: .default , handler:{ (UIAlertAction)in
            self.retrieveData(preferences: "popular", page: 1, language: "en")
            self.loadBar()
        }))

        alert.addAction(UIAlertAction(title: "Upcoming", style: .default , handler:{ (UIAlertAction)in
            self.retrieveData(preferences: "upcoming", page: 1, language: "en")
            self.loadBar()
        }))

        alert.addAction(UIAlertAction(title: "Top Rated", style: .default , handler:{ (UIAlertAction)in
            self.retrieveData(preferences: "top_rated", page: 1, language: "en")
            self.loadBar()
        }))

        alert.addAction(UIAlertAction(title: "Now Playing", style: .default , handler:{ (UIAlertAction)in
            self.retrieveData(preferences: "now_playing", page: 1, language: "en")
            self.loadBar()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @IBAction func favoritePressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Favorite", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "favoriteViewController") as! FavoriteViewController
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    
    private func retrieveData(preferences : String, page : Int, language : String) {
        viewModel.fetchMovieData(preferences: preferences, page: page, language: language) { _ in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinner.hidesWhenStopped = true
                self.dashboardMoviesTableView.reloadData()
            }
        }
    }
    
    private func loadBar() {
        if viewModel.isLoading {
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
        } else {
            self.spinner.startAnimating()
            self.spinner.hidesWhenStopped = false
        }
    }
    
}

extension DashboardViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = dashboardMoviesTableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let movies = viewModel.cellForRowAt(indexPath: indexPath)
        customCell.updateUI(movieData: movies)
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.moviesData = viewModel.cellForRowAt(indexPath: indexPath)
        vc.listForm = "Dashboard"
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    
}

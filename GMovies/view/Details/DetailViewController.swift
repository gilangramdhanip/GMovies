//
//  DetailViewController.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 01/05/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailNavigation: UINavigationItem!
    @IBOutlet weak var segmentedIndex: UISegmentedControl!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var movieStatus: UILabel!
    private var favPressed : Bool?
    var moviesID : Int64?
    var listForm : String?
    var favMovies: [Movies] = []
    var moviesData : Movie?
    var segmentSelected = 0
    private var overview : String?
    private var author : String?
    private var viewModel = MoviesDetailViewModel()
    private var reviewViewModel = MoviesReviewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        loadDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDetail()
        detailTableView.reloadData()
    }
    
    func loadDetail(){
        favMovies = PersitanceManager.shared.fetchFavoriteMovie()
        if listForm == "Dashboard" {
            moviesID = Int64(moviesData!.id)
            
        }
            spinner.startAnimating()
            spinner.hidesWhenStopped = false

            for item in favMovies {
                if item.id == moviesID! {
                    if item.isFavorite == false {
                        favPressed = true
                        favButton.image = UIImage(systemName: "heart")
                    } else {
                        favPressed = false
                        favButton.image = UIImage(systemName: "heart.fill")
                    }
                }
            }
            
        viewModel.fetchDetailMovieData(idMovies: Int(moviesID!), language: "en-US"){ data in
                self.spinner.stopAnimating()
                self.spinner.hidesWhenStopped = true
                self.detailNavigation.title = data.title
                self.movieTitle.text = data.title
            self.movieStatus.text = data.status
            
            let date = self.convertDateFormat(inputDate: data.releaseDate)
            self.movieReleaseDate.text = "\(date)"
                self.overview = data.overview
            self.moviePopularity.text = "\(data.popularity )"
                let imageUrl = "https://image.tmdb.org/t/p/w500\(data.posterPath)"
                self.movieImage.cacheImage(urlString: imageUrl)
                self.detailTableView.reloadData()
                        
            self.reviewViewModel.fetchMovieReview(idMovie: data.id){ data in
                
                    DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.spinner.hidesWhenStopped = true
                    self.detailTableView.reloadData()
                }

            }
        }
    
    }

    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy"

         return convertDateFormatter.string(from: oldDate!)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func segmentedSelected(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            segmentSelected = 0
        }else {
            segmentSelected = 1
        }
        detailTableView.reloadData()
    }
    
    @IBAction func favoritePressed(_ sender: Any) {
                    
            if favPressed == false {
                favPressed = true
                favButton.image = UIImage(systemName: "heart")
                for item in favMovies {
                    if item.id == moviesID! {
                        PersitanceManager.shared.unFavoriteMovies(movies: item)
                        showToast(controller: self, message: "Removed favorite movie", seconds: 1.0, navigationController : navigationController!)
                    }
                }
            } else {
                favPressed = false
                favButton.image = UIImage(systemName: "heart.fill")
                PersitanceManager.shared.favoriteMovies(movie: moviesData!, isFavorite: true)
                showToast(controller: self, message: "Added favorite movie", seconds: 1.0, navigationController : navigationController!)
            }
        

    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double, navigationController : UINavigationController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
            navigationController.popViewController(animated: true)
        }
    }
    
    
    
}

extension DetailViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentSelected == 0 {
            return 1
        }else {
            return reviewViewModel.numberOfRowsInSection(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  detailTableView.dequeueReusableCell(withIdentifier: "cellSegmented", for: indexPath) as! ReviewTableViewCell

        if segmentSelected == 0 {
            cell.reviewLabe.text = overview
            cell.authorLabel.isHidden = true
        }else {
            cell.authorLabel.isHidden = false
            cell.setData(data: reviewViewModel.cellForRowAt(indexPath: indexPath))
            
        }
        return cell
    }
    
    
}

//
//  ListTableViewCell.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 01/05/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "moviesCell"
    private var isCompleted : Bool = false
    
    static func nib()-> UINib {
        return UINib(nibName: "ListTableViewCell", bundle: nil)
    }

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieShortDescrtiption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func updateUI(movieData : Movie){
        let date = self.convertDateFormat(inputDate: movieData.releaseDate)
        movieTitle.text = movieData.title
        movieReleaseDate.text = "\(date)"
        movieShortDescrtiption.text = movieData.overview
        
        
        let imageUrl = "https://image.tmdb.org/t/p/w500\(movieData.posterPath)"
        
        movieImage.cacheImage(urlString: imageUrl)
        
    }
    
    func updateUIFavorite(movieData : Movies) {
        let date = self.convertDateFormat(inputDate: movieData.releaseDate!)
        movieTitle.text = movieData.title
        movieReleaseDate.text = "\(date)"
        movieShortDescrtiption.text = movieData.overview
        
        
        let imageUrl = "https://image.tmdb.org/t/p/w500\(movieData.posterPath ?? "")"
        
        movieImage.cacheImage(urlString: imageUrl)
    }
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy"

         return convertDateFormatter.string(from: oldDate!)
    }
    
}

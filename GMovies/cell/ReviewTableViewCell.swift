//
//  ReviewTableViewCell.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 08/05/22.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewLabe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data : Review) {
        
        print("data content \(data.content)")
        reviewLabe.text = data.content
        authorLabel.text = data.author
    }

}

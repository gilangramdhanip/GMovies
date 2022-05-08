//
//  FavoriteViewController.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 03/05/22.
//

import UIKit

class FavoriteViewController: ViewController {

    @IBOutlet weak var favroiteTableView: UITableView!
    var favoriteList = [Movies]()
    @IBOutlet weak var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favroiteTableView.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier )

        favroiteTableView.delegate = self
        favroiteTableView.dataSource = self
        
        fetchFavData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavData()
        showEmpty()
    }
    func fetchFavData() {
        favoriteList = PersitanceManager.shared.fetchFavoriteMovie()
        self.favroiteTableView.reloadData()
    }
    
    func showEmpty(){
        if favoriteList.count == 0 {
            emptyLabel.text = "Favorite is empty"
            emptyLabel.isHidden = false
        }else{
            emptyLabel.isHidden = true
        }
    }

}


extension FavoriteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoriteList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = favroiteTableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
        let movies = favoriteList[indexPath.row]
        customCell.updateUIFavorite(movieData: movies)
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.moviesID = favoriteList[indexPath.row].id
        vc.listForm = "Favorite"
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }


}

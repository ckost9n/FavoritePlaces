//
//  MainTableViewController.swift
//  FavoritePlaces
//
//  Created by Konstantin on 26.09.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private let places = Place.getPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        let restoraunt = places[indexPath.row]
        cell.nameLabel.text = restoraunt.name
        cell.locationLabel.text = restoraunt.location
        cell.typeLabel.text = restoraunt.type
        cell.imageOfPlace.image = UIImage(named: restoraunt.image)
        
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        
        

        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}
    

}

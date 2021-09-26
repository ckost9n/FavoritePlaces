//
//  MainTableViewController.swift
//  FavoritePlaces
//
//  Created by Konstantin on 26.09.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    private let restaurantNames = Restorant.restaurantNames

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let restauran = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: restauran)
        cell.textLabel?.text = restauran

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

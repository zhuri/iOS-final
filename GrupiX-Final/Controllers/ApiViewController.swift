//
//  ApiViewController.swift
//  GrupiX-Final
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit

class ApiViewController: UIViewController {
    @IBOutlet weak var apiTableView: UITableView!
    var locationService: LocationService? = nil
    var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiTableView.delegate = self
        apiTableView.dataSource = self
        
        self.getAPICall()
    }
    
    func getAPICall(){
        self.locationService = LocationService()
        self.locationService?.getLocations(completion: { (success, arrOfCity, error) in
            if success {
                self.cities = arrOfCity
                self.apiTableView.reloadData()
            } else {
                self.showErrorAlert()
            }
        })
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "An error occurred", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak alert] (_) in
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ApiViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ApiViewCell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath) as! ApiViewCell
        
        let city = cities[indexPath.row]
        //here we complete the image view as well
        cell.nameLabel.text = city.name
        let URLStr = "https://picsum.photos/200/300?random"
        let data = NSData(contentsOf: NSURL(string: URLStr)! as URL)
        cell.imageView?.image = UIImage(data: data! as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.showDeleteAlert(indexPath: indexPath, tableView: tableView)
        }
    }
    
    func showDeleteAlert(indexPath: IndexPath, tableView: UITableView) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this city ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak alert] (_) in
            print("Deleted")
            //request for deletion but I do not have an API for this
            self.cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { [weak alert] (_) in
            return
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension ApiViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: ApiViewCell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath) as! ApiViewCell
        let cityController = self.storyboard?.instantiateViewController(withIdentifier: "CityViewController") as! CityViewController
        cityController.city = self.cities[indexPath.row]
        cityController.image = cell.imageView?.image
        self.present(cityController, animated: true, completion: nil)
    }
}

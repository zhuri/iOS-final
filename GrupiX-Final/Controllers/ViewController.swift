//
//  ViewController.swift
//  GrupiX-Final
//
//  Created by Cacttus Education 12 on 5/9/18.
//  Copyright © 2018 Cacttus Education 12. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addLocationBtn: UIButton!
    @IBOutlet weak var refreshListBtn: UIButton!
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var locationsArray: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addLocationButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Location", message: "Enter location data", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "Enter Id"
        }
        alert.addTextField { (textField) in
            textField.text = "Enter Name"
        }
        alert.addTextField { (textField) in
            textField.text = "Enter latitude"
        }
        alert.addTextField { (textField) in
            textField.text = "Enter longitude"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textFieldId = alert?.textFields![0]
            let textFieldName = alert?.textFields![1]
            let textFieldLatitude = alert?.textFields![2]
            let textFieldLongitude = alert?.textFields![3]
            let id: Int = Int(textFieldId!.text!)!
            let name: String = (textFieldName!.text!)
            let latitude: Double = Double(textFieldLatitude!.text!)!
            let longitude: Double = Double(textFieldLongitude!.text!)!
            let location = Location.init(id: id, name: name, latitude: latitude, longitude: longitude)
            self.addLocation(location: location)
            self.tableView.reloadData()
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        fillLocationsArray()
    }
    
    private func addLocation(location: Location) {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: context)
        let newLocation = NSManagedObject.init(entity: entity!, insertInto: context)
        
        newLocation.setValue(location.id, forKey: "id")
        newLocation.setValue(location.name, forKey: "name")
        newLocation.setValue(location.latitude, forKey: "latitude")
        newLocation.setValue(location.longitude, forKey: "longitude")
        
        do{
            try context.save()
            print("came here")
            self.tableView.reloadData()
        } catch{
            print("fail to save")
        }
    }
    
    private func fillLocationsArray() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                
                let id = data.value(forKey: "id") as! Int
                let name = data.value(forKey: "name") as! String
                let latitude = data.value(forKey: "latitude") as! Double
                let longitude = data.value(forKey: "longitude") as! Double
                let location = Location(id: id, name: name, latitude: latitude, longitude: longitude)
                locationsArray.append(location)
                self.tableView.reloadData()
                print(location.name)
            }
            
        }catch {
            print("could not read data..")
        }
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationCell
        let location = locationsArray[indexPath.row]
        
        cell.updateViews(with: location)
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let qyteti = qytetet[indexPath.row]
//
//        print("indexpath.row: \(qyteti.name)")
    }
}


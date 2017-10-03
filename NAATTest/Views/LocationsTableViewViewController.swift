//
//  LocationsTableViewViewController.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

class LocationsTableViewViewController: UIViewController {
    
    @IBOutlet weak var tblImages: UITableView!
    var locations = [RLocation]()
    var selectedLocation = RLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        tblImages.dataSource = self
        tblImages.delegate = self
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.removeNavigationBar()
        self.customizeNavigationBar()
        
        self.showLocations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    internal func removeNavigationBar() {
        let nav = self.navigationController?.navigationBar
        if let subviews = nav?.subviews {
            for subView in subviews {
                if(subView.tag != 0){
                    subView.removeFromSuperview()
                }
            }
        }
    }
    
    func customizeNavigationBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationItem.title = "Tabla de imagenes"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Verdana", size: 15)!]
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "showMapView" {
            let destination = segue.destination as? MapViewController
            destination!.selectedLocation = self.selectedLocation
        }
    }
    
 
    func showLocations(){
        let locationsController = LocationsController()
        let newArray = locationsController.getLocations()
        self.locations = newArray.sorted{$0.distance < $1.distance}
        self.tblImages.reloadData()
    }


}



// MARK: UITableViewDataSource
extension LocationsTableViewViewController : UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LocationDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationDetailTableViewCellID") as! LocationDetailTableViewCell
        
        let selectedLocation = self.locations[indexPath.row]
        cell.configureLoctionRow(for: selectedLocation)
        
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension LocationsTableViewViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedLocation = self.locations[indexPath.row]
        self.performSegue(withIdentifier: "showMapView", sender: self)
    }
    
}




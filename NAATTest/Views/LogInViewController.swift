//
//  ViewController.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

class LogInViewController: BaseViewController {
    @IBOutlet weak var txfLat: UITextField!
    @IBOutlet weak var txflng: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnGet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.stopAnimating()
        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.removeNavigationBar()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setStyle()
        
    }
    
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
    
    
    @IBAction func getLocations(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork() == true {
            if (txfLat.text!.characters.count > 0 && txflng.text!.characters.count > 0){
                self.activityIndicator.startAnimating()
                
                let locationsController = LocationsController()
                locationsController.delegate = self
                locationsController.makeRequestLocationsWithParametters(txfLat.text!, lng: txflng.text!)
            }
            else{
                self.showAlert("Aviso", message: "Debes proporcionar latitud y longitud")
            }
        }
        else{
           self.showAlert("Aviso", message: "No dispone de una conexión a internet estable")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushe
        
        if segue.identifier == "showTableView" {
        }
    }

    
    
    internal func setStyle(){
        
        self.btnGet.backgroundColor = self.uicolorFromHex(0x1483C6)
        self.btnGet.layer.cornerRadius = 25
        self.btnGet.layer.borderWidth = 1
        self.btnGet.layer.borderColor = self.uicolorFromHex(0x1483C6).cgColor
        
    }


}

extension LogInViewController : LocationsControllerDelegate{
    
    func doneMakeRequestLocationsWithParametters(result: String, success: Bool) {
        activityIndicator.stopAnimating()
        if(success){
            self.performSegue(withIdentifier: "showTableView", sender: self)
        }else{
            //Mostrar alerta
            self.showAlert("Aviso", message: result)
        }
    }
}


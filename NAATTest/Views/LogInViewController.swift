//
//  ViewController.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

class LogInViewController: BaseViewController {
    @IBOutlet weak var txfUser: UITextField!
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnLogIn: UIButton!
    
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
    
    
    @IBAction func logIn(_ sender: Any) {
        if (txfUser.text!.characters.count > 0 && txfPassword.text!.characters.count > 0){
            self.activityIndicator.startAnimating()
            
            let locationsController = LocationsController()
            locationsController.delegate = self
            locationsController.makeRequestUsersWithParametters(txfUser.text!, lng: txfPassword.text!)
        }
        else{
            self.showAlert("Aviso", message: "Debes proporcionar latitud y longitud")
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
        
        self.btnLogIn.backgroundColor = self.uicolorFromHex(0x1483C6)
        self.btnLogIn.layer.cornerRadius = 25
        self.btnLogIn.layer.borderWidth = 1
        self.btnLogIn.layer.borderColor = self.uicolorFromHex(0x1483C6).cgColor
        
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


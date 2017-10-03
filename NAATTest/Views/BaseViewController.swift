//
//  BaseViewController.swift
//  NAATTest
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func LogW(_ msg:String, function: String = #function, file: String = #file, line: Int = #line){
        print("[WARNING] \(makeTag(function, file: file, line: line)) : \(msg)")
        print("")
    }
    
    fileprivate func makeTag(_ function: String, file: String, line: Int) -> String{
        let url = URL(fileURLWithPath: file)
        let className:String! = url.lastPathComponent.characters.count == 0 ? file: url.lastPathComponent
        return "\(className) \(function)[\(line)]"
    }

    
    func uicolorFromHex(_ rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    
    
    let alertController = UIAlertController(title: "Destructive", message: "Simple alertView demo with Destructive and Ok.", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
    let DestructiveAction = UIAlertAction(title: "Destructive", style: UIAlertActionStyle.destructive) {
        (result : UIAlertAction) -> Void in
        print("Destructive")
    }
    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
        (result : UIAlertAction) -> Void in
        print("OK")
    }
    func showAlert(_ tittle : String , message : String){
        
        ////alertController.addAction(DestructiveAction)
        //alertController.addAction(okAction)
        //self.present(alertController, animated: true, completion: nil)
    
        let alert = UIAlertController(title: tittle,
                                      message: message,
                                      preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "OK",
                                          style: .default) {(_) in
                                            // your defaultButton action goes here
        }
        
        alert.addAction(defaultButton)
        present(alert, animated: true) {
            // completion goes here
        }
    
    }
    
    
    func iPhoneScreenSizes() -> CGFloat{
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 480.0:
            print("iPhone 3,4")
            return 5
        case 568.0:
            print("iPhone 5")
             return 6
        case 667.0:
            print("iPhone 6")
             return 12
        case 736.0:
            print("iPhone 6+")
             return 17
        default:
            print("not an iPhone")
            
        }
        
        return 65
    }
    
    
    func tableRwoSizeForResolution() -> CGFloat{
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 480.0:
            print("iPhone 3,4")
            return 172.0
        case 568.0:
            print("iPhone 5")
            return 172.0
        case 667.0:
            print("iPhone 6")
            return 172.0
        case 736.0:
            print("iPhone 6+")
            return 172.0
        default:
            print("not an iPhone")
        }
        
        return 330.0
    }
    
    func deviceIsIpad() -> Bool{
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
        // It's an iPhone
            return false
        case .pad:
        // It's an iPad
            return true
        case .unspecified:
            // Uh, oh! What could it be?
            return false
        default:
            break
        }
        
        return false
    }

    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func goHome(){
        self.navigationController?.popToRootViewController(animated: true)
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}

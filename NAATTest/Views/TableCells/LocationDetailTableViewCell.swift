//
//  ImagesDetailTableViewCell.swift
//  AMKTestExercise
//
//  Created by Juan Carlos Pérez D. on 10/2/17.
//  Copyright © 2017 Juan Carlos Pérez. All rights reserved.
//

import UIKit

class LocationDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDistance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureLoctionRow(for location: RLocation) {
        
        if location.name.isEmpty {
            lblName.text = "Sin descripción"
        } else {
            lblName.text = "Nombre: \(location.name)"
        }
        
        if location.address.isEmpty {
            lblAddress.text = "Sin descripción"
        } else {
            lblAddress.text = "Dir: \(location.address)"
        }
        
        if location.distance <= 0 {
            lblDistance.text = "Sin descripción"
        } else {
            lblDistance.text = "Distancia: \(location.distance) m."
        }
        
    }
    
}

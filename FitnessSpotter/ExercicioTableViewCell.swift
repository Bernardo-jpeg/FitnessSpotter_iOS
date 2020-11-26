//
//  ExercicioTableViewCell.swift
//  FitnessSpotter
//
//  Created by Bernardo José Ribeiro Figueiredo on 24/11/2020.
//  Copyright © 2020 IPLeiria DDM. All rights reserved.
//

import UIKit

class ExercicioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nomeExercicioLabel: UILabel!
    @IBOutlet weak var intensidadeExercicioControl: IntensityControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

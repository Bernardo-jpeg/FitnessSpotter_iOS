//
//  PlanoDeTreino.swift
//  FitnessSpotter
//
//  Created by Bernardo José Ribeiro Figueiredo on 25/11/2020.
//  Copyright © 2020 IPLeiria DDM. All rights reserved.
//

import Foundation

class PlanoDeTreino {
    var nome: String
    var arrayExercicios = [Exercicio]()
    
    init?(nome: String, arrayExercicios: [Exercicio]) {
        
        // Initialize stored properties.
        self.nome = nome
        self.arrayExercicios = arrayExercicios
    }
}

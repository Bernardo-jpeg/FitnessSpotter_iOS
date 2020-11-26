//
//  ExercicioTableViewController.swift
//  FitnessSpotter
//
//  Created by Bernardo José Ribeiro Figueiredo on 24/11/2020.
//  Copyright © 2020 IPLeiria DDM. All rights reserved.
//

import UIKit
import os.log

class ExercicioTableViewController: UITableViewController {
    
    var exercicios = [Exercicio]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        loadSampleExercicios()
    }
    
    private func loadSampleExercicios(){
        guard let exercicio1 = Exercicio(nome: "Pular Corda(Aeróbico)",series: 10, peso:0, repeticoes:10, intensidade: 5)
            else {
                fatalError("Unable to instantiate exercicio1")
        }
        
        guard let exercicio2 = Exercicio(nome: "Flexão de Braços",series: 10, peso:0, repeticoes:10,  intensidade: 2)
            else {
                fatalError("Unable to instantiate exercicio2")
        }
        
        guard let exercicio3 = Exercicio(nome: "Barra Fixa",series: 10, peso:0, repeticoes:10,  intensidade: 1)
            else {
                fatalError("Unable to instantiate exercicio3")
        }
        
        guard let exercicio4 = Exercicio(nome: "Levantar Pesos",series: 10, peso:0, repeticoes:10,  intensidade: 6)
            else {
                fatalError("Unable to instantiate exercicio4")
        }
        exercicios += [exercicio1, exercicio2, exercicio3, exercicio4]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercicios.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExercicioTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExercicioTableViewCell else {
            fatalError("The dequeued cell is not an instance of ExercicioTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let exercicio = exercicios[indexPath.row]
        cell.nomeExercicioLabel.text = exercicio.nome
        cell.intensidadeExercicioControl.intensidade = exercicio.intensidade
        
        return cell
    }
    
    @IBAction func unwindToExerciciosList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ViewController,
            let exercicio = sourceViewController.exercicio {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                exercicios[selectedIndexPath.row] = exercicio
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: exercicios.count, section: 0)
                
                exercicios.append(exercicio)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new exercice.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let exercicioDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedExercicioCell = sender as? ExercicioTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedExercicioCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedExercicio = exercicios[indexPath.row]
            exercicioDetailViewController.exercicio = selectedExercicio
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            exercicios.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
}

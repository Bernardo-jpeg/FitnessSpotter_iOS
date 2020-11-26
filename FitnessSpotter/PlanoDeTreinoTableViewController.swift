//
//  PlanoDeTreinoTableViewController.swift
//  FitnessSpotter
//
//  Created by Bernardo José Ribeiro Figueiredo on 26/11/2020.
//  Copyright © 2020 IPLeiria DDM. All rights reserved.
//

import UIKit
import os.log

class PlanoDeTreinoTableViewController: UITableViewController {
    
    var planosTreino = [PlanoDeTreino]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSamplePlanoDeTreinos()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return planosTreino.count
    }
    
    private func loadSamplePlanoDeTreinos(){
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
        
        
        guard let planoTreino1 = PlanoDeTreino(nome: "Plano Semanal", arrayExercicios: [exercicio1] )
            else {
                fatalError("Unable to instantiate planoTreino1")
        }
        
        guard let planoTreino2 = PlanoDeTreino(nome: "Plano Natal", arrayExercicios: [exercicio2] )
            else {
                fatalError("Unable to instantiate planoTreino1")
        }
        
        guard let planoTreino3 = PlanoDeTreino(nome: "Plano Pascoa", arrayExercicios: [exercicio3] )
            else {
                fatalError("Unable to instantiate planoTreino1")
        }
        
        planosTreino += [planoTreino1, planoTreino2, planoTreino3]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PlanoDeTreinoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlanoDeTreinoTableViewCell else {
            fatalError("The dequeued cell is not an instance of PlanoDeTreinoTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let planoTreino = planosTreino[indexPath.row]
        cell.planoTreinoNomeLabel.text = planoTreino.nome
        
        return cell
    }
    
    @IBAction func unwindToPlanoTreinoList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ViewController,
            let planoTreino = sourceViewController.planoTreino {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                planosTreino[selectedIndexPath.row] = planoTreino
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: planosTreino.count, section: 0)
                
                planosTreino.append(planoTreino)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     super.prepare(for: segue, sender: sender)

     switch(segue.identifier ?? "") {

     case "AddItem":
     os_log("Adding a new plano de treino.", log: OSLog.default, type: .debug)

     case "ShowExerciciosList":
     guard let planoTreinoViewController = segue.destination as? ViewController else {
     fatalError("Unexpected destination: \(segue.destination)")
     }

     guard let selectedPlanoTreinoCell = sender as? PlanoDeTreinoTableViewCell else {
        fatalError("Unexpected sender: \(String(describing: sender))")
     }

     guard let indexPath = tableView.indexPath(for: selectedPlanoTreinoCell) else {
     fatalError("The selected cell is not being displayed by the table")
     }

     let selectedPlanoTreino = planosTreino[indexPath.row]
     planoTreinoViewController.planoTreino = selectedPlanoTreino

     default:
        fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
     }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

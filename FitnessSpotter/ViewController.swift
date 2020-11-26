//
//  ViewController.swift
//  FitnessSpotter
//
//  Created by Bernardo José Ribeiro Figueiredo on 23/11/2020.
//  Copyright © 2020 IPLeiria DDM. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var exercicio: Exercicio?
    var planoTreino: PlanoDeTreino?
    
    @IBOutlet weak var nomeExercicioTextField: UITextField!
    @IBOutlet weak var seriesTextField: UITextField!
    @IBOutlet weak var pesoTextField: UITextField!
    @IBOutlet weak var repeticoestextField: UITextField!
    @IBOutlet weak var IntensidadeControl: IntensityControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomeExercicioTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let exercicio = exercicio {
            navigationItem.title = exercicio.nome
            nomeExercicioTextField.text = exercicio.nome
            seriesTextField.text = "\(exercicio.series)"
            pesoTextField.text = "\(exercicio.peso)"
            repeticoestextField.text = "\(exercicio.repeticoes)"
            IntensidadeControl.intensidade = exercicio.intensidade
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let nome = nomeExercicioTextField.text ?? ""
        let series = Int(seriesTextField.text!)
        let peso = Int(seriesTextField.text!)
        let repeticoes = Int(seriesTextField.text!)
        let intensidade = IntensidadeControl.intensidade
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        exercicio = Exercicio(nome: nome, series: series!, peso: peso!, repeticoes: repeticoes!, intensidade: intensidade)
    }
    
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
    
    
    
}


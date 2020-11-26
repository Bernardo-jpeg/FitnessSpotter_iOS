//
//  IntensityControl.swift
//  FitnessSpotter
//
//  Created by Bernardo José Ribeiro Figueiredo on 23/11/2020.
//  Copyright © 2020 IPLeiria DDM. All rights reserved.
//

import UIKit

@IBDesignable class IntensityControl: UIStackView {
    
    private var intensidadeButtons = [UIButton]()
    var intensidade = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var iconSize: CGSize = CGSize(width: 22, height: 44.0)
        {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var iconCount: Int = 6 {
        didSet {
            setupButtons()
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder){
        super.init(coder: coder)
    }
    
    private func setupButtons() {
        for button in intensidadeButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        intensidadeButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledIntensidadeVerde = UIImage(named: "filledIntensidadeVerde", in: bundle, compatibleWith: self.traitCollection)
        //let filledIntensidadeAmarelo = UIImage(named: "filledIntensidadeAmarelo", in: bundle, compatibleWith: self.traitCollection)
        //let filledIntensidadeVermelho = UIImage(named: "filledIntensidadeVermelho", in: bundle, compatibleWith: self.traitCollection)
        
        let emptyIntensidade = UIImage(named:"emptyIntensidade", in: bundle, compatibleWith: self.traitCollection)
        let highlightedIntensidade = UIImage(named:"highlightedIntensidade", in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<iconCount {
            let button = UIButton()
            button.setImage(emptyIntensidade, for: .normal)
            button.setImage(filledIntensidadeVerde, for: .selected)
            button.setImage(highlightedIntensidade, for: .highlighted)
            button.setImage(highlightedIntensidade, for: [.highlighted, .selected])
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            
            
            button.addTarget(self, action: #selector(IntensityControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            intensidadeButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = intensidadeButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(intensidadeButtons)")
        }
        // Calculate the rating of the selected button
        let selectedIntensidade = index + 1
        if selectedIntensidade == intensidade {
            // If the selected star represents the current rating, reset the intensidade to 0.
            intensidade = 0
        } else {
            // Otherwise set the rating to the selected star
            intensidade = selectedIntensidade
        }
    }
    
    private func updateButtonSelectionStates() {
        
        
        for (index, button) in intensidadeButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < intensidade
        }
    }
    
    
}

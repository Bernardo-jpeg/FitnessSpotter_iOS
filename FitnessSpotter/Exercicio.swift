
import Foundation

class Exercicio {
    var nome: String
    var series: Int
    var peso: Int
    var repeticoes: Int
    var intensidade: Int
    
    init?(nome: String, series: Int, peso: Int, repeticoes: Int, intensidade: Int) {
        
        // Initialize stored properties.
        self.nome = nome
        self.series = series
        self.peso = peso
        self.repeticoes = repeticoes
        self.intensidade = intensidade
    }
}


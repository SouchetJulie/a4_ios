import UIKit

var array = ["Hello", "world"] // var = variable, let = constante

for el in array {
    print(el)
}

array.append("!")
print(type(of: array))

for (index, value) in array.enumerated() {
    print("\(index) -> \(value)")
}

print("-------------------------")

for i in 10...13 { // inclus
    print(i)
}

for i in 20..<23 { // exclus
    print(i)
}

print("-------------------------")

var dico = [
    "cinquante-deux": 52,
    "douze": 12
]
print(dico.keys)
print(dico.values)

dico["douze"] = 13

for (key, value) in dico {
    if value == 52 {
        print("\(key) -> \(value)")
    }
}

print("-------------------------")

var value: String? = "value" // valeur optionnelle (= nullable)

if let tmp = value, tmp == "other" { // initialisation de la variable ‘tmp‘ si ‘value‘ est définie et ‘tmp‘ == "other"
    print(tmp)
} else {
    print("nope")
} // -> nope
// print(exists) -> erreur: n'existe pas hors du bloc ci-dessus !

func check () {
    guard let tmp = value else {
        return
        // exists n'existe pas à l'intérieur
    }
    print(tmp) // existe à l'extérieur
}
check() // -> value

print(value!) // force l'existence -> value
print(value as Any) // -> Optional("value")
print(value ?? "default") // -> value

print("-------------------------")

let number = 5

switch number {
case 1:
    print("un")
case 0...9: // range
    print("chiffre")
default:
    print("unknown")
}

// équivalents
if (0...9).contains(number) {
    
}
if number <= 0 && number < 10 {
    
}

print("-------------------------")

enum Niveau : String {
    case un
    case deux
    case trois
    case quatre
    case cinq
}

protocol Ecoole { // = interface
    func getNom() -> String // le typage du retour est optionnel
    func getNiveau() -> String
}

class Teacher {
    func setGrade() {
        print("set grade")
    }
}


class Eleve: Teacher, Ecoole, CustomStringConvertible { // hérite de la classe-mère, et adopte le protocole (implémente l'interface)
    var note: Int
    var niveau: Niveau
    private var nom: String
    static var ecole: String = "IIM"
    
    init(_ note: Int, niveau: Niveau, nom: String = "toto") { // _ = label caché
        self.note = note
        self.niveau = niveau
        self.nom = nom
    }
    
    var description: String { // computed property
        "\(nom): Année \(niveau), \(note)/20" // le ‘self.’ est optionnel quand il n'y a pas d'ambiguité
    }
    
    func setNom(nom: String) {
        self.nom = nom
    }
    
    func getNom() -> String {
        nom // le ‘return’ est optionnel quand il n'y a qu'une ligne
    }
    
    var nomPublic: String { // getter
        nom
    }
    
    func getNiveau() -> String {
        niveau.rawValue
    }
    
    override func setGrade() {
        Swift.print("rien à voir")
    }
}

print(Eleve.ecole)

struct Eleve2 { // similaire à ‘class‘, mais passe par référence plutôt que par copie comme ‘class‘
}

let mio = Eleve(
    19,  // les paramètres doivent respecter l'ordre, même avec les labels
    niveau: .cinq // .<membre de l'énumération>
)

print(mio)
mio.niveau = .quatre
print(mio)

// print(mio.nom) -> erreur : private
print(mio.getNom())
print(mio.nomPublic)
// mio.nomPublic = "tutu" -> erreur: nomPublic est get-only

Teacher().setGrade()
mio.setGrade()

print("-------------------------")

extension Int { // ajoute des fonctionnalités à un type (ici, Int)
    func next() -> String {
        (self + 1).description
    }
}

print(11.next()) // -> "12"

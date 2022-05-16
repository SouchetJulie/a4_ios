//
//  Networker.swift
//  table
//
//  Created by SOUCHET Julie on 16/05/2022.
//

import Foundation

class Networker {
    // @escaping permet d'utiliser une ‘closure’ pour des opérations asynchrones
    // completion correspond à la closure utilisée lors de l'appel de la fonction (‘fetch’ ici)
    static func fetch(_ url: URL, completion: @escaping ([DataModel]) -> ()) {
        // ci-dessous est une ‘closure’, l'équivalent du .then en JS
        // ‘data’, ‘response’ et ‘error’ sont en l'occurrence le résultat récupéré par la fonction
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion([])
                return print("no data")
            }

            do {
                // convertir la donnée reçue en JSON
                let json = try JSONDecoder().decode([DataModel].self, from: data) // params = (type, rawData)
                // appeler le callback avec la donnée ci-convertie
                completion(json)
            } catch let error {
                completion([])
                print(error.localizedDescription)
            }
        }.resume() // lance la requête
    }
}

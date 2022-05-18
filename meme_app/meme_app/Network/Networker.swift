//
//  Networker.swift
//  meme_app
//
//  Created by SOUCHET Julie on 17/05/2022.
//

import Foundation

class Networker<T: Codable> {
    // @escaping permet d'utiliser une ‘closure’ pour des opérations asynchrones
    // completion correspond à la closure utilisée lors de l'appel de la fonction (‘fetch’ ici)
    static func fetch(_ url: URL, completion: @escaping (T) -> ()) {
        // ci-dessous est une ‘closure’, l'équivalent du .then en JS
        // ‘data’, ‘response’ et ‘error’ sont en l'occurrence le résultat récupéré par la fonction
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return print("no data")
            }

            do {
                // convertir la donnée reçue en JSON
                let json = try JSONDecoder().decode(T.self, from: data) // params = (type, rawData)
                // appeler le callback avec la donnée ci-convertie
                completion(json)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume() // lance la requête
    }
}

//
//  Networker.swift
//  td5
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import Foundation

class Networker<T: Codable> {
  static func fetch(_ url: URL, completion: @escaping (T) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let result = data else {
        return print("no data")
      }

      do {
        let json = try JSONDecoder().decode(T.self, from: result)
        completion(json)
      } catch let DecodingError.dataCorrupted(context) {
        print(context)
      } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let DecodingError.typeMismatch(type, context)  {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
      } catch let error {
        print("error: ", error)
      }
    }.resume()
  }
}

//
//  NetworkLayer.swift
//  Practica-Fundamentos-iOS
//
//  Created by David Robles Lopez on 26/12/22.
//

import Foundation

enum NetworkError: Error {
    case malformeURL
    case noData
    case statusCode(code: Int?)
    case decodingFailed
    case unknown
}

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    func login(email: String, password: String, completion: @escaping(String?, Error?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/auth/login") else {    // Si la url no es valida, nos devuelve un error
            completion(nil, NetworkError.malformeURL)
            return
        }
        
        let loginString = "\(email):\(password)"                                                        // email y password lo hemos pasado a base 64
        let loginData: Data = loginString.data(using: .utf8)!
        let base64 = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")                     // Aquí le metemos la cabecera
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {                                                                   // Con esto miramos si hay error, si el error no es nulo, algo ha ido mal
                completion(nil, error)
                return
            }
            
            guard let data = data else {                                                                // Con esto miramos si vienen datos, si no, nos devuelve el error
                completion(nil, NetworkError.noData)
                return
            }
            
            guard ( response as? HTTPURLResponse)?.statusCode == 200 else {                            // Comprobamos que el statusCode sea igual a 200 para continuar
                let statusCode = ( response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: statusCode))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else {                              // Aquí el data lo hemos convertido en un token
                completion(nil, NetworkError.decodingFailed)
                return
            }
            
            completion(token, nil)                                                                   // Si ha ido bien, nos devuelve nuestro token
        }
        
        task.resume()
    }
    
    func fetchHeroes(token: String?, completion: @escaping( [Heroe]?, Error?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/heros/all") else {    // Si la url no es valida, nos devuelve un error
            completion(nil, NetworkError.malformeURL)
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)                             
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let heroes = try?JSONDecoder().decode([Heroe].self, from: data) else {
                completion(nil, NetworkError.decodingFailed)
                return
            }
            
            completion(heroes, nil)
        }
        task.resume()
    }
}

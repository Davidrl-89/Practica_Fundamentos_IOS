//
//  LocalDataLayer.swift
//  Practica-Fundamentos-iOS
//
//  Created by David Robles Lopez on 26/12/22.
//

import Foundation

final class LocalDataLayer {
    
    private static let token = "token"
    private static let heroes = "heroes"
    
    
    static let shared = LocalDataLayer()
    
    // Token
    
    func save(token: String) {                                                                 // Función para guardar el token
        return UserDefaults.standard.set(token, forKey: Self.token)                            // Este Self se pone en mayuscula, por que es una propiedad estatica, es igual                                                                                          que poner el nombre de la clase(LocalDataLayer)
    }
    
    func getToken() -> String {                                                               // Función para traer todos los heroes
        return UserDefaults.standard.string(forKey: Self.token) ?? ""
    }
    
    func isUsserLogged() -> Bool {                                                            // Función para saber si el usuario ya esta logeado
        return !getToken().isEmpty
    }
    
    func save(heroes: [Heroe]) {
        if let encodeHeroes = try? JSONEncoder().encode(heroes) {
            UserDefaults.standard.set(encodeHeroes, forKey: Self.heroes)
        }
    }
    
    func getHeroes() -> [Heroe] {
        if let savedHeroesData = UserDefaults.standard.object(forKey: Self.heroes) as? Data {
            do {
                let savedHeroes = try JSONDecoder().decode([Heroe].self, from: savedHeroesData)
                return savedHeroes
            } catch {
                print("Something went wrong!!")
                return []
            }
        } else {
            return []
        }
        
    }
}

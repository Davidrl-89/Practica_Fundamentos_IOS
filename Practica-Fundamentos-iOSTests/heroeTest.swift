//
//  heroeTest.swift
//  Practica-Fundamentos-iOSTests
//
//  Created by David Robles Lopez on 31/12/22.
//

import XCTest
@testable import Practica_Fundamentos_iOS

final class heroeTest: XCTestCase {
    
    var heroe: Heroe!

    override func setUp() {
        super.setUp()
        
        heroe = Heroe(id: "4",
                      name: "Goku",
                      photo: "https//www.keepcoding.io",
                      description: "Goku always win!!",
                      favorite: false)
    }

    override func tearDown() {
        heroe = nil
        super.tearDown()
    }
    
    func testHeroeId() {
        XCTAssertNotNil(heroe.id)
        XCTAssertEqual(heroe.id, "4")
        XCTAssertNotEqual(heroe.id, "7")
    }
    
    func testHeroeName() {
        XCTAssertNotNil(heroe.name)
        XCTAssertEqual(heroe.name, "Goku")
        XCTAssertNotEqual(heroe.name, "Vegeta")
    }
    
    func testHeroePhoto() {
        let url = URL(string: heroe.photo)
        
        XCTAssertNotNil(heroe.photo)
        XCTAssertEqual(heroe.photo, "https//www.keepcoding.io")
        XCTAssertNotEqual(heroe.photo, "https//www.keepcoding.com")
        
        XCTAssertNotNil(url)
    }
    func testHeroeDescription() {
        XCTAssertNotNil(heroe.description)
        XCTAssertEqual(heroe.description, "Goku always win!!")
        XCTAssertNotEqual(heroe.description, "Goku alwaSS win!!!")
    }
    
    func testHeroeFav() {
        XCTAssertNotNil(heroe.favorite)
        XCTAssertEqual(heroe.favorite, false)
       
    }
   

}

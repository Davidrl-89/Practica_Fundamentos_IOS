//
//  TransformationsTest.swift
//  Practica-Fundamentos-iOSTests
//
//  Created by David Robles Lopez on 31/12/22.
//

import XCTest

final class TransformationsTest: XCTestCase {
    
    var transformation : Transformation!

    override func setUp() {
        super.setUp()
        
        transformation = Transformation(id: "22",
                                       name: "Super saiyan",
                                       photo: "https//www.keepcoding.io",
                                       description: "This is the real one")
    }

    override func tearDown() {
        super.tearDown()
    
    }
    func testTransformationId() {
        
        XCTAssertNotNil(transformation.id)
        XCTAssertEqual(transformation.id, "22")
        XCTAssertNotEqual(transformation.id, "23")
    }
    
    func testTransformationName() {
        XCTAssertNotNil(transformation.name)
        XCTAssertEqual(transformation.name, "Super saiyan")
        XCTAssertNotEqual(transformation.name, "Super saiyan Blue")
    }
    
    func testTransformationPhoto() {
        let url = URL(string: transformation.photo)
        
        XCTAssertNotNil(transformation.photo)
        XCTAssertEqual(transformation.photo, "https//www.keepcoding.io")
        XCTAssertNotEqual(transformation.photo, "https//www.keepcoding.com")
        
        XCTAssertNotNil(url)
    }
    func testTransformationDescription() {
        XCTAssertNotNil(transformation.description)
        XCTAssertEqual(transformation.description, "This is the real one")
        XCTAssertNotEqual(transformation.description, "This is the real one!")
    }

   
    

}

//
//  StateObservableButtonTests.swift
//  AugmentedButtonTests
//
//  Created by Antonio Cabezuelo Vivo on 12/03/2019.
//  Copyright © 2019 Antonio Cabezuelo Vivo. All rights reserved.
//

import XCTest
import AugmentedButton

class StateObservableButtonTests: XCTestCase {

    var sut: StateObservableButton!

    
    override func setUp() {
        super.setUp()
        
        sut = StateObservableButton(type: .custom)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testStateChangedOnSelected() {
        let stub = Stub()
        sut.addTarget(stub, action: #selector(Stub.stateChanged), for: .stateChanged)
        
        XCTAssertFalse(stub.changed)
        sut.isSelected = true
        XCTAssertTrue(stub.changed)
    }

    func testStateChangedOnHighlighted() {
        let stub = Stub()
        sut.addTarget(stub, action: #selector(Stub.stateChanged), for: .stateChanged)

        XCTAssertFalse(stub.changed)
        sut.isHighlighted = true
        XCTAssertTrue(stub.changed)
    }

    func testStateChangedOnDisabled() {
        let stub = Stub()
        sut.addTarget(stub, action: #selector(Stub.stateChanged), for: .stateChanged)
        
        XCTAssertFalse(stub.changed)
        sut.isEnabled = false
        XCTAssertTrue(stub.changed)
    }
}

private
final class Stub: NSObject {
    var changed: Bool = false
    
    @objc
    func stateChanged() {
        self.changed = true
    }
}

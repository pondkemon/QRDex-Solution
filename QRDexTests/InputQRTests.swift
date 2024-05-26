//
//  InputQRTests.swift
//  QRDexTests
//
//  Created by Apinun Wongintawang on 27/5/2567 BE.
//

import XCTest
@testable import QRDex

final class InputQRTests: XCTestCase {
    var inputQrViewController: InputQrViewController!

    override func setUpWithError() throws {
        inputQrViewController = InputQrViewController()
    }

    override func tearDownWithError() throws {
        inputQrViewController = nil
    }

    func testFirstDigitNotZero_validWhenGenQR_displayErrorFirstCharactorIsNotZero() throws {
        let invalidNumber: String = "189-421-8571"
        
        let error = inputQrViewController.validTelFormat(tel: invalidNumber)
        
        XCTAssertEqual(error, .FirstCharactorIsNotZero)
    }
    
    func testNumber11Digit_validWhenGenQR_displayErrorNot10Digit() throws {
        let invalidNumber: String = "023-123-12345"
        
        let error = inputQrViewController.validTelFormat(tel: invalidNumber)
        
        XCTAssertEqual(error, .Not10Digit)
    }
    
    func testNumberOrdering_validWhenGenQR_displayErrorOrderingNumber() throws {
        let invalidNumber: String = "012-345-6789"
        
        let error = inputQrViewController.validTelFormat(tel: invalidNumber)
        
        XCTAssertEqual(error, .OrderingNumber)
    }
    
    func testAllSingleNumber_validWhenGenQR_displayErrorOrderingNumber() throws {
        let invalidNumber: String = "011-111-1111"
        
        let error = inputQrViewController.validTelFormat(tel: invalidNumber)
        
        XCTAssertEqual(error, .AllSingleNumber)
    }
    
    func testLast4Digit_validWhenGenQR_displayErrorNotOrderingLast4Digit() throws {
        // Test
    }
}

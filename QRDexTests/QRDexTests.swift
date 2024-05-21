//
//  QRDexTests.swift
//  QRDexTests
//
//  Created by Wittawas Mukdaprasert on 21/5/2567 BE.
//

import XCTest
import QRDex

final class QRDexTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testQrGenaraterService() throws {
        print("* Test QrGenaraterService")
        print("- genarate image should not nil")
        let qrService = QrGenaraterService()
        let image = qrService.getQRSting(tel: "0923092019")
        XCTAssertNotNil( image, "image nil" )
        
    }
    
    func testPokedexService() throws {
        print("* Test pokedexService")
        print("- Api should received data")
        let pokedexService = PokedexService()
        pokedexService.execute(request: "")
        XCTAssertNotNil( "data", "Error receive data" )
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

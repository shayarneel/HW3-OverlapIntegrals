//
//  Tests_macOS.swift
//  Tests macOS
//
//  Created by Shayarneel Kundu on 2/17/22.
//

import XCTest
import HW3_OverlapIntegrals

class Tests_macOS: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testH1s()  throws {
            
        var H1swavefunction = radialPsiOneS(rho: 0.0, theta: 0.0, phi: 0.0)
        let bohrRadius = 0.5292 //defined in Angstrom
        let coeffPsiOneS = sqrt(Double.pi * pow(bohrRadius,3.0))
       
        var answer = 1/coeffPsiOneS
        XCTAssertEqual(H1swavefunction, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        H1swavefunction = radialPsiOneS(rho: 1.0, theta: 0.0, phi: 0.0)
        
       
        answer = 1/coeffPsiOneS * exp(-1/bohrRadius)
        print (H1swavefunction, answer)
        XCTAssertEqual(H1swavefunction, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    func test1px()  throws {
            
        var Twopxwavefunction = radialPsiTwoPx(rho: 0.0, theta: 0.0, phi: 0.0)
        
        let bohrRadius = 0.5292 //defined in Angstrom
        let coeffPsitwoPx = 4*sqrt(2*Double.pi * pow(bohrRadius,3.0))
       
        var answer = 0.0
        XCTAssertEqual(Twopxwavefunction, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        Twopxwavefunction = radialPsiTwoPx(rho: 1.0, theta: Double.pi/2, phi: 0.0)
        let radTrail1 = (1.0/bohrRadius)*exp(-1.0/(2.0*bohrRadius))
        
        answer = radTrail1/coeffPsitwoPx
        
        XCTAssertEqual(Twopxwavefunction, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        Twopxwavefunction = radialPsiTwoPx(rho: 1.0, theta: Double.pi/2, phi: Double.pi/2)

        answer = 0.0
        
        XCTAssertEqual(Twopxwavefunction, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    func testSphereCoords() throws {
        
        var firstTest = SphericalToCartesian(xval: 0.0, yval: 0.0, zval: 0.0)
        
        var answer = (0.0, 0.0, 0.0)
        
        XCTAssertEqual(firstTest.0, answer.0, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        XCTAssertEqual(firstTest.1, answer.1, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        XCTAssertEqual(firstTest.2, answer.2, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        
        firstTest = SphericalToCartesian(xval: -1.0, yval: 1.0, zval: -sqrt(2.0))
        
        answer = (2.0, 0.75*Double.pi, 0.75*Double.pi)
        
        XCTAssertEqual(firstTest.0, answer.0, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        XCTAssertEqual(firstTest.1, answer.1, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        XCTAssertEqual(firstTest.2, answer.2, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        firstTest = SphericalToCartesian(xval: 1.0, yval: sqrt(3.0), zval: 2.0)
        
        answer = (2.0*sqrt(2.0), 0.25*Double.pi, Double.pi/3)
        
        XCTAssertEqual(firstTest.0, answer.0, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        XCTAssertEqual(firstTest.1, answer.1, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        XCTAssertEqual(firstTest.2, answer.2, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    func testAverage() throws{
        
        
        let overlap = CalculateOverlap()
        
        var averageTest = overlap.calculateAverage(data: [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0])
        
        var answer = 0.0
        
        
        XCTAssertEqual(averageTest, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
        averageTest = overlap.calculateAverage(data: [0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0])
        
        answer = 5.0
        
        
        XCTAssertEqual(averageTest, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
    }
    
    func testVolume() throws{
        
        
        let volumeCalculator = BoundingBox()
        
        let Vol = volumeCalculator.calculateVolume(xmin: -1.0, xmax: 1.0, ymin: -1.0, ymax: 1.0, zmin: -1.0, zmax: 1.0)
        
        let answer = 8.0
        
        
        XCTAssertEqual(Vol, answer, accuracy: 1.0E-7, "Was not equal to this resolution.")
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

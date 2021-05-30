//
//  AnalyticsCenterTests.swift
//  AnalyticsCenterTests
//
//  Created by Anton Kaliuzhnyi on 30.05.2021.
//

import XCTest
@testable import AnalyticsCenter

final class AnalyticsCenterTests: XCTestCase {
    
    func testEventParameters() {
        let analyticsCenter = AnalyticsCenter()
        let testableAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: nil
        )
        analyticsCenter.add(testableAnalyticsService)
        analyticsCenter.start()
        XCTAssertTrue(testableAnalyticsService.isStartCalled)
        
        let now = Date()
        let event = TestableAnalyticsEvent(
            name: "oneTwoThree",
            parameters: [
                "String": "A string",
                "Int": 123,
                "Double": 45.67,
                "Bool": true,
                "Date": now
            ]
        )
        analyticsCenter.track(event)
        XCTAssertEqual(testableAnalyticsService.lastEventName, "oneTwoThree")
        
        let lastEventParameters = testableAnalyticsService.lastEventParameters
        XCTAssertEqual(lastEventParameters?["String"] as? String, "A string")
        XCTAssertEqual(lastEventParameters?["Int"] as? Int, 123)
        XCTAssertEqual(lastEventParameters?["Double"] as? Double, 45.67)
        XCTAssertEqual(lastEventParameters?["Bool"] as? Bool, true)
        XCTAssertEqual(lastEventParameters?["Date"] as? Date, now)
    }
    
    private let event1 = TestableAnalyticsEvent(
        name: "oneTwoThree",
        parameters: nil
    )
    
    private let event2 = TestableAnalyticsEvent(
        name: "one twO thRee",
        parameters: nil
    )
    
    private let event3 = TestableAnalyticsEvent(
        name: "one1 t2wo thr_ee",
        parameters: nil
    )
    
    private let event4 = TestableAnalyticsEvent(
        name: "one1TwoThr3eeF4ourFi(v)e6Si(x)",
        parameters: nil
    )
    
    private let event5 = TestableAnalyticsEvent(
        name: "OneT2w;oThr%;ee1F44our(Five)SiX",
        parameters: nil
    )
    
    private let event6 = TestableAnalyticsEvent(
        name: "; on1E2__two ThRee_Fo.ur  ",
        parameters: nil
    )
    
    private let event7 = TestableAnalyticsEvent(
        name: "Fir%st_Sec;o4#nd_T•hi🐱rd",
        parameters: nil
    )
    
    func testCamelCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .camelCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "oneTwoThree")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "oneTwoThree")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1T2woThrEe")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1TwoThr3eeF4ourFiVE6SiX")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "oneT2wOThrEe1F44ourFiveSiX")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "on1e2TwoThreeFoUr")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "firStSecO4NdTHiRd")
    }
    
    func testCapitalizedCamelCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .capitalizedCamelCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "OneTwoThree")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "OneTwoThree")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1T2woThrEe")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1TwoThr3eeF4ourFiVE6SiX")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "OneT2wOThrEe1F44ourFiveSiX")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "On1e2TwoThreeFoUr")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "FirStSecO4NdTHiRd")
    }
    
    func testSnakeCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .snakeCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one_two_three")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one_two_three")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1_t2wo_thr_ee")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1_two_thr3ee_f4our_fi_v_e6_si_x")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one_t2w_o_thr_ee1_f44our_five_si_x")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "on1e2_two_three_fo_ur")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "fir_st_sec_o4_nd_t_hi_rd")
    }
    
    func testCapitalizedSnakeCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .capitalizedSnakeCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One_Two_Three")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One_Two_Three")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1_T2wo_Thr_Ee")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1_Two_Thr3ee_F4our_Fi_V_E6_Si_X")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One_T2w_O_Thr_Ee1_F44our_Five_Si_X")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "On1e2_Two_Three_Fo_Ur")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "Fir_St_Sec_O4_Nd_T_Hi_Rd")
    }
    
    func testUpperSnakeCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .upperSnakeCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE_TWO_THREE")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE_TWO_THREE")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE1_T2WO_THR_EE")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE1_TWO_THR3EE_F4OUR_FI_V_E6_SI_X")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE_T2W_O_THR_EE1_F44OUR_FIVE_SI_X")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ON1E2_TWO_THREE_FO_UR")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "FIR_ST_SEC_O4_ND_T_HI_RD")
    }
    
    func testKebabCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .kebabCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one-two-three")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one-two-three")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1-t2wo-thr-ee")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1-two-thr3ee-f4our-fi-v-e6-si-x")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one-t2w-o-thr-ee1-f44our-five-si-x")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "on1e2-two-three-fo-ur")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "fir-st-sec-o4-nd-t-hi-rd")
    }
    
    func testCapitalizedKebabCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .capitalizedKebabCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One-Two-Three")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One-Two-Three")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1-T2wo-Thr-Ee")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1-Two-Thr3ee-F4our-Fi-V-E6-Si-X")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One-T2w-O-Thr-Ee1-F44our-Five-Si-X")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "On1e2-Two-Three-Fo-Ur")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "Fir-St-Sec-O4-Nd-T-Hi-Rd")
    }
    
    func testUpperKebabCaseEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .upperKebabCase)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE-TWO-THREE")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE-TWO-THREE")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE1-T2WO-THR-EE")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE1-TWO-THR3EE-F4OUR-FI-V-E6-SI-X")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE-T2W-O-THR-EE1-F44OUR-FIVE-SI-X")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ON1E2-TWO-THREE-FO-UR")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "FIR-ST-SEC-O4-ND-T-HI-RD")
    }
    
    func testSentenceEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .sentence)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One two three")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One two three")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1 t2wo thr ee")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1 two thr3ee f4our fi v e6 si x")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One t2w o thr ee1 f44our five si x")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "On1e2 two three fo ur")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "Fir st sec o4 nd t hi rd")
    }
    
    func testCapitalizedEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .capitalized)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One Two Three")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One Two Three")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1 T2wo Thr Ee")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One1 Two Thr3ee F4our Fi V E6 Si X")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "One T2w O Thr Ee1 F44our Five Si X")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "On1e2 Two Three Fo Ur")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "Fir St Sec O4 Nd T Hi Rd")
    }
    
    func testLowercasedEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .lowercased)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one two three")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one two three")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1 t2wo thr ee")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one1 two thr3ee f4our fi v e6 si x")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "one t2w o thr ee1 f44our five si x")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "on1e2 two three fo ur")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "fir st sec o4 nd t hi rd")
    }
    
    func testUppercasedEventNameFormatter() {
        let analyticsCenter = AnalyticsCenter()
        let snakeCaseAnalyticsService = TestableAnalyticsService(
            apiToken: "1234",
            eventNameFormatter: EventNameFormatter(format: .uppercased)
        )
        analyticsCenter.add(snakeCaseAnalyticsService)
        
        analyticsCenter.track(event1)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE TWO THREE")
        
        analyticsCenter.track(event2)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE TWO THREE")
        
        analyticsCenter.track(event3)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE1 T2WO THR EE")
        
        analyticsCenter.track(event4)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE1 TWO THR3EE F4OUR FI V E6 SI X")
        
        analyticsCenter.track(event5)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ONE T2W O THR EE1 F44OUR FIVE SI X")
        
        analyticsCenter.track(event6)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "ON1E2 TWO THREE FO UR")
        
        analyticsCenter.track(event7)
        XCTAssertEqual(snakeCaseAnalyticsService.lastEventName, "FIR ST SEC O4 ND T HI RD")
    }
    
}

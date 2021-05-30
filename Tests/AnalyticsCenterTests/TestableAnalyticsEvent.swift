//
//  TestableAnalyticsEvent.swift
//  AnalyticsCenterTests
//
//  Created by Anton Kaliuzhnyi on 30.05.2021.
//

import Foundation
@testable import AnalyticsCenter

struct TestableAnalyticsEvent: AnalyticsEvent {
    
    var name: String
    
    var parameters: [String: Any]?
    
}

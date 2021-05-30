//
//  TestableAnalyticsService.swift
//  AnalyticsCenterTests
//
//  Created by Anton Kaliuzhnyi on 30.05.2021.
//

import Foundation
@testable import AnalyticsCenter

class TestableAnalyticsService: AnalyticsService {
    
    let apiToken: String
    
    let eventNameFormatter: AnalyticsEventNameFormatter?
    
    var isStartCalled: Bool = false
    
    var lastEventName: String = ""
    
    var lastEventParameters: [String: Any]? = nil
    
    init(apiToken: String, eventNameFormatter: AnalyticsEventNameFormatter?) {
        self.apiToken = apiToken
        self.eventNameFormatter = eventNameFormatter
    }
    
    func start() {
        isStartCalled = true
    }
    
    func track(_ event: AnalyticsEvent) {
        lastEventName = eventNameFormatter?.format(event.name) ?? event.name
        lastEventParameters = event.parameters
    }
    
}

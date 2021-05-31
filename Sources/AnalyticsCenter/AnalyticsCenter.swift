//
//  AnalyticsCenter.swift
//  AnalyticsCenter
//
//  Created by Anton Kaliuzhnyi on 13.05.2021.
//

import Foundation

open class AnalyticsCenter: AnalyticsService {
    
    public static let shared: AnalyticsCenter = AnalyticsCenter()
    
    private(set) var services: [AnalyticsService] = []
    
    public init() {
    }
    
    open func add(_ service: AnalyticsService) {
        services.append(service)
    }
    
    open func start() {
        services.forEach {
            $0.start()
        }
    }
    
    open func track(_ event: AnalyticsEvent) {
        services.forEach {
            $0.track(event)
        }
    }
    
}

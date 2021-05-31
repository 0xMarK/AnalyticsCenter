//
//  AnalyticsService.swift
//  AnalyticsCenter
//
//  Created by Anton Kaliuzhnyi on 13.05.2021.
//

import Foundation

public protocol AnalyticsService {
    
    func start()
    
    func track(_ event: AnalyticsEvent)
    
}

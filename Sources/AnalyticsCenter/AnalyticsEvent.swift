//
//  AnalyticsEvent.swift
//  AnalyticsCenter
//
//  Created by Anton Kaliuzhnyi on 13.05.2021.
//

import Foundation

public protocol AnalyticsEvent {
    
    var name: String { get }
    var parameters: [String: Any]? { get }
    
}

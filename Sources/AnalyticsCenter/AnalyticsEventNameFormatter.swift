//
//  AnalyticsEventNameFormatter.swift
//  AnalyticsCenter
//
//  Created by Anton Kaliuzhnyi on 18.05.2021.
//

import Foundation

public protocol AnalyticsEventNameFormatter {
    
    func format(_ name: String) -> String
    
}

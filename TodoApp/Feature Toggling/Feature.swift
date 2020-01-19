import Foundation

enum Feature: String, CaseIterable {
    
    case addItem
    
    static let enabledByDefault: [Feature] = [
        .addItem
    ]
}

import SwiftUI

struct Movie: Identifiable, Codable {
    var id = UUID()
    var title: String
    var releaseYear: Int
    var rating: Double
    var description: String
    var posterImageData: Data?
    var posterURL: String?
    
    var formattedRating: String {
        String(format: "%.1f", rating)
    }
}

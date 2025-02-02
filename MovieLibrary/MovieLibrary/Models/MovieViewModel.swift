import SwiftUI
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText = ""
    @Published var sortOption: SortOption = .title
    
    enum SortOption {
        case title, rating, year
    }
    
    var filteredMovies: [Movie] {
        let filtered = movies.filter { movie in
            searchText.isEmpty || movie.title.localizedCaseInsensitiveContains(searchText)
        }
        
        switch sortOption {
        case .title:
            return filtered.sorted { $0.title < $1.title }
        case .rating:
            return filtered.sorted { $0.rating > $1.rating }
        case .year:
            return filtered.sorted { $0.releaseYear > $1.releaseYear }
        }
    }
    
    init() {
        loadMovies()
    }
    
    func loadMovies() {
        if let data = UserDefaults.standard.data(forKey: "movies"),
           let savedMovies = try? JSONDecoder().decode([Movie].self, from: data) {
            movies = savedMovies
        }
    }
    
    func saveMovies() {
        if let encoded = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(encoded, forKey: "movies")
        }
    }
    
    func addMovie(_ movie: Movie) {
        movies.append(movie)
        saveMovies()
    }
    
    func deleteMovie(_ movie: Movie) {
        movies.removeAll { $0.id == movie.id }
        saveMovies()
    }
    
    func updateMovie(_ movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[index] = movie
            saveMovies()
        }
    }
}

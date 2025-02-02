import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var showingAddMovie = false
    
    var body: some View {
        NavigationView {
            VStack {
                SearchSortBar(searchText: $viewModel.searchText,
                            sortOption: $viewModel.sortOption)
                
                List {
                    ForEach(viewModel.filteredMovies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                            MovieRowView(movie: movie)
                        }
                    }
                }
            }
            .navigationTitle("Movie Library")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddMovie = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMovie) {
                AddMovieView(viewModel: viewModel)
            }
        }
    }
}

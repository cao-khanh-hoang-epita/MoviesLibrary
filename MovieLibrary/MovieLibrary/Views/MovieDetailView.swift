import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingEditSheet = false
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageData = movie.posterImageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 400)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(movie.title)
                        .font(.title)
                    
                    HStack {
                        Text("Release Year: \(movie.releaseYear)")
                        Spacer()
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(movie.formattedRating)
                        }
                    }
                    .font(.headline)
                    
                    Text(movie.description)
                        .font(.body)
                }
                .padding()
            }
        }
        .navigationBarItems(trailing: HStack {
            Button(action: { showingEditSheet = true }) {
                Text("Edit")
            }
            Button(action: deleteMovie) {
                Image(systemName: "trash")
            }
        })
        .sheet(isPresented: $showingEditSheet) {
            AddMovieView(viewModel: viewModel)
        }
    }
    
    private func deleteMovie() {
        viewModel.deleteMovie(movie)
        presentationMode.wrappedValue.dismiss()
    }
}

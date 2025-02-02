import SwiftUI

struct AddMovieView: View {
    @ObservedObject var viewModel: MovieViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var releaseYear = Calendar.current.component(.year, from: Date())
    @State private var rating = 3.0
    @State private var description = ""
    @State private var showingImagePicker = false
    @State private var posterImage: UIImage?
    @State private var posterURL = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Movie Details")) {
                    TextField("Title", text: $title)
                    Stepper("Release Year: \(releaseYear)", value: $releaseYear, in: 1900...Calendar.current.component(.year, from: Date()))
                    VStack {
                        Text("Rating: \(rating, specifier: "%.1f")")
                        Slider(value: $rating, in: 0...5, step: 0.5)
                    }
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Poster")) {
                    Button(action: { showingImagePicker = true }) {
                        Text("Select Image")
                    }
                    TextField("Or enter image URL", text: $posterURL)
                }
            }
            .navigationTitle("Add Movie")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveMovie()
                }
                .disabled(title.isEmpty)
            )
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $posterImage)
            }
        }
    }
    
    private func saveMovie() {
        var imageData: Data?
        if let image = posterImage {
            imageData = image.jpegData(compressionQuality: 0.8)
        }
        
        let movie = Movie(
            title: title,
            releaseYear: releaseYear,
            rating: rating,
            description: description,
            posterImageData: imageData,
            posterURL: posterURL.isEmpty ? nil : posterURL
        )
        
        viewModel.addMovie(movie)
        presentationMode.wrappedValue.dismiss()
    }
}

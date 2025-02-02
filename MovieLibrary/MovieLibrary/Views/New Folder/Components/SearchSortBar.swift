import SwiftUI

struct SearchSortBar: View {
    @Binding var searchText: String
    @Binding var sortOption: MovieViewModel.SortOption
    
    var body: some View {
        VStack {
            TextField("Search movies...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Picker("Sort by", selection: $sortOption) {
                Text("Title").tag(MovieViewModel.SortOption.title)
                Text("Rating").tag(MovieViewModel.SortOption.rating)
                Text("Year").tag(MovieViewModel.SortOption.year)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}

//
//  Shop.swift
//  Foodie
//
//  Created by Алина on 24.05.24.
//



import SwiftUI

struct Shop: View {
    @Environment(\.presentationMode) var presentationMode
    @State var goToCart = false
    @State private var searchText: String = ""
    @State private var filteredItems = shopItems
    
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var items: [[Any]] = shopItems
    
    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView {
                
                
                /*SearchView(searchText: $searchText)
                 .frame(height:50)
                 .padding(.horizontal)
                 */
                ScrollView() {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(0..<items.count, id:\.self) { item in
                            ShopItem(imageName: items[item][0] as! String, title: items[item][1] as! String, price: items[item][2] as! Double, color: items[item][3] as! Color, selfIndex: item)
                        }
                    }
                }.padding(.bottom, 15)
                
                
                    .fullScreenCover(isPresented: $goToCart) {
                        Cart()
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button() {
                                goToCart = true
                            }label: {
                                Image(systemName: "cart")
                            }
                        }
                    }
                
            }
            .navigationViewStyle(.stack)
            .searchable(text: $searchText, prompt: "Food and products")
            .onChange(of: searchText) { newValue in filterItems(searchText: newValue)}
        } else {
            // Fallback on earlier versions
        }
        
    }
    func filterItems(searchText: String){
        if searchText.isEmpty {
            filteredItems = shopItems
        } else {
            filteredItems = shopItems.filter { item in
                let title = item[1] as! String
                return title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

/*struct SearchView : View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search", text :$searchText)
                .foregroundColor(.black)
            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .opacity(searchText == "" ? 0: 1)
            }
        }
        .padding(.horizontal, 10)
        .background(Color.white)
        .cornerRadius(10)
        
    }
}*/

struct Shop_Previews: PreviewProvider {
    static var previews: some View {
        Shop()
    }
}

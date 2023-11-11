//
//  ContentView.swift
//  Instafilter
//
//  Created by Ray Nahimi on 11/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    //select an image
                }
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                    
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change filter"){
                        //change filter
                    }
                    
                    Spacer()
                    
                    Button("Save"){
                        //save
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

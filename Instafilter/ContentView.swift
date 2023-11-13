//
//  ContentView.swift
//  Instafilter
//
//  Created by Ray Nahimi on 11/11/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
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
                    showingImagePicker = true
                }
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing()
                            
                        }
                    
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change filter"){
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
                .padding([.horizontal, .bottom])
                .navigationTitle("Instafilter")
                .onChange(of: inputImage){_ in loadImage()}
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .confirmationDialog("Select a filter", isPresented: $showingFilterSheet){
                    Button("Crystallize"){seFilter(CIFilter.crystallize())}
                    Button("Edges"){seFilter(CIFilter.edges())}
                    Button("Gaussian Blur"){seFilter(CIFilter.gaussianBlur())}
                    Button("Pixellate"){seFilter(CIFilter.pixellate())}
                    Button("Sepia Tone"){seFilter(CIFilter.sepiaTone())}
                    Button("Vignette"){seFilter(CIFilter.vignette())}
                    Button("Cancel", role: .cancel){}
                }
            }
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else { return }
        
        let beginimage = CIImage(image: inputImage)
        currentFilter.setValue(beginimage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    func save() {
        
    }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
        
        
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let  cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    func seFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

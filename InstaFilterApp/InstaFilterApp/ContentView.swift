//
//  ContentView.swift
//  InstaFilterApp
//
//  Created by Tony Capelli on 04/10/22.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var imageLoaded = false
    
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
                .onTapGesture { showingImagePicker = true }
                
                HStack{
                    Text("Filte intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) {_ in applyProcessing()}
                }
                .padding(.vertical)
                
                HStack{
                    Text("Filte radius")
                    Slider(value: $filterRadius, in: 0...100)
                        .onChange(of: filterRadius) {_ in applyProcessing()}
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change Filter"){
                        showingFilterSheet = true
                    }
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(!imageLoaded)
                }

            }
            .padding([.horizontal,.bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage){ _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select Filter", isPresented: $showingFilterSheet) {
                Button("Crystalize"){ setFilter(CIFilter.crystallize()) }
                Button("Edges"){ setFilter(CIFilter.edges()) }
                Button("Gaussian Blur"){ setFilter(CIFilter.gaussianBlur()) }
                Button("Pixelate"){ setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone"){ setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp mask"){ setFilter(CIFilter.unsharpMask()) }
                Button("Vignette"){ setFilter(CIFilter.vignette()) }
                Button("Bloom"){ setFilter(CIFilter.bloom()) }
                Button("Cancel", role: .cancel) { }
                
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        imageLoaded = true
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save(){
        guard let processedImage = processedImage else {return}
        
        let imageSaver = ImageSaver()
        imageSaver.succesHandler = {
            print("success")
        }
        
        imageSaver.errorHandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
   
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter){
        currentFilter = filter
        print(currentFilter.inputKeys.debugDescription)
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

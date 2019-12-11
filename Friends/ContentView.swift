//
//  ContentView.swift
//  Friends
//
//  Created by Mihai Leonte on 09/12/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var lastImage: UIImage?
    @State private var showingNameInput = false
    @State private var fullName: String = ""
    @ObservedObject var contacts = Contacts()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                List {
                    if showingNameInput {
                        
                        HStack {
                            Image(uiImage: lastImage!)
                                .resizable()
                                .scaledToFit()
                                //.frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color.red, lineWidth: 5))
                                
                            
                            TextField("Full Name", text: self.$fullName)
                            
                            Spacer()
                                
                            Button(action: {
                                let newUUID = UUID()
                                let newContact = Contact(id: newUUID, name: self.fullName)
                                self.contacts.contacts.append(newContact)
                                
                                self.contacts.images[newUUID] = self.lastImage
                                self.saveData()
                                self.saveImage(imageName: "\(newUUID)", image: self.lastImage!)
                                
                                self.fullName = ""
                                self.showingNameInput = false
                            }) {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    .padding()
                            }.disabled(fullName == "")
                            
                        }
                        
                    }
                    ForEach(contacts.contacts.sorted(), id: \.self) { contact in
                        NavigationLink(destination:
                            Image(uiImage: self.contacts.images[contact.id]!)
                                .resizable()
                                .scaledToFit()
                            ) {
                            HStack {
                                Image(uiImage: self.contacts.images[contact.id]!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.red, lineWidth: 5))
                                    .padding(.trailing)
                                
                                Text("\(contact.name)")
                                    .font(.title)
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                }
                
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.showingImagePicker = true
                        }) {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.red.opacity(0.9))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$lastImage)
                        }
                    }
                }
                
            }
            .navigationBarTitle(Text("SayMyName"))
            
        }
    //.onAppear(perform: loadImagesFromDisk)
        
    }
    
    func loadImage() {
        guard let inputImage = lastImage else { return }
        self.showingNameInput = true
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedContacts")
            let data = try JSONEncoder().encode(self.contacts.contacts)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func saveImage(imageName: String, image: UIImage) {
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
            print(fileURL)
        } catch let error {
            print("error saving file with error", error)
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

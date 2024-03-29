//
//  ContentView.swift
//  QRViewSwiftUI
//
//  Created by MauroMarzocca on 24/02/24.


import SwiftUI

struct ContentView: View {
    var body: some View {
        QRView()
    }
}

#Preview {
    ContentView()
}















struct QRView: View {
    @State private var searchText: String = ""
    @State private var qrCodeImageURL: URL?

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            Circle()
                .foregroundStyle(.blue.opacity(0.2))
                .offset(x: 100,y: -400)
            
            Circle()
                .foregroundStyle(.blue.opacity(0.2))
                .offset(x: -200,y: 400)

            VStack {
                HStack {
                    Text("QR \nGenerator")
                        .foregroundStyle(.white)
                        .fontWeight(.regular)
                    .font(. system(size: 72))
                    Spacer()
                }.padding(15)
                
                
                
                HStack {
                    TextField("Enter text", text: $searchText)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundStyle(.white)

                    Spacer()

                
                    generateQRCodeButton()
                }.padding(20)
                Spacer()
                if let qrCodeImageURL = qrCodeImageURL {
                    generateQRCodeImage(url: qrCodeImageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                } else {
                    Text("QR Code Will Appear Here")
                        .foregroundColor(.white)
                }
                Spacer()
            }
        
        }
    }

    func generateQRCodeButton() -> some View {
        Button(action: {
            if let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let urlString = "https://chart.googleapis.com/chart?cht=qr&chs=500x500&chl=\(encodedText)"
                if let url = URL(string: urlString) {
                    qrCodeImageURL = url
                }
            }
        }) {
            Text("Generate QR")
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }

    func generateQRCodeImage(url: URL) -> Image {
        guard let imageData = try? Data(contentsOf: url),
              let uiImage = UIImage(data: imageData),
              let cgImage = uiImage.cgImage else {
            return Image(systemName: "xmark.circle")
        }
        let image = Image(uiImage: UIImage(cgImage: cgImage))
        return image
    }
}

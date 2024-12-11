//
//  QRScanner.swift
//  NameStack_tabbar
//
//  Created by 이현서 on 11/5/24.
//

import SwiftUI
import UIKit


/*
struct QRScanner: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path:NavigationPath
    @Binding var isTabBarVisible: Bool

    
    var body: some View {

        ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
            Text("QRScanner").foregroundStyle(.white)
                }

    }
}
*/

import SwiftUI
import VisionKit

struct QRScanner: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path:NavigationPath
    @Binding var isTabBarVisible: Bool

    
    @State var isShowingScanner = true
    @State private var scannedText = ""
    @State private var i = 0

    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            
            HStack(){
                
                
                Text("NameStack")
                    .font(Font.custom("Jura", size: 30).weight(.bold))
                    .foregroundColor(.white)
                    .position(x: UIScreen.main.bounds.width / 2, y: 20)
                    
            }
            

            

            VStack{
                /*if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {*/
                ZStack(alignment: .bottom) {
                    
                    DataScannerRepresentable(
                        shouldStartScanning: $isShowingScanner,
                        scannedText: $scannedText,
                        path: $path,
                        dataToScanFor: [.barcode(symbologies: [.qr])]
                    ).frame(height: 500).shadow(radius: 1).background(.white)
                }
                Text(scannedText)

                    
                /*} else if !DataScannerViewController.isSupported {
                    Text("It looks like this device doesn't support the DataScannerViewController")
                } else {
                    Text("It appears your camera may not be available")
                }*/
            }
        }
    }
}


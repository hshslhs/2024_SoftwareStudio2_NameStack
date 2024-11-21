//
//  MainScreen.swift
//  NameStack
//
//  Created by 이현서 on 11/5/24.
//
import SwiftUI
import UIKit

struct MainScreen: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path:NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    @State private var showHomeButton = false
    
    var body: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                withAnimation {
                isTabBarVisible=false
                isSidebarVisible.toggle()
                }
            }) {
                Image("sidebar")
                    .padding(
                        EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                    )
            }
            .frame(width: 30, height: 30)
            .position(x: 50, y: 20);
            
            Text("NameStack")
                .font(Font.custom("Jura", size: 30).weight(.bold))
                .foregroundColor(.white)
                .frame(width: 175, height: 35)
                .position(x: UIScreen.main.bounds.width / 2, y: 20);
            
            VStack() {
  
                Spacer()
                
            }
            
        }
    }
    
}


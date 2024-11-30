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
    @State private var mainSearchText: String = "Search.."

    var body: some View {

        ZStack() {
            Color.black.ignoresSafeArea(.all)
            
            LoopingScrollView()
                .padding(.bottom, 30)
            
            ZStack(){
                ZStack{
                    Button(action: {
                        withAnimation {
                        isTabBarVisible=false//사이드 바 열릴 때 탭 바 닫기
                        dismissKeyboard()//사이드 바 열릴 때 키보드 닫기
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
                }
                HStack(){
                    HStack(){
                     

                        TextField("Search", text: $mainSearchText)
                            .font(Font.custom("Urbanist", size: 18))
                            .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                            .frame(width: 229, height: 30)
                        Spacer() .frame(width: 5)
                        
                        
                        
                        Button(action: {
                            mainSearchText = "" // Clear search text
                        }) {
                            Image("eraseAll")
                                .foregroundColor(.gray)
                        }
                        Spacer() .frame(width: 11)
                        
                        Button(action: {
                            
                        }) {
                            Image("search")
                                .foregroundColor(.gray)
                                .padding(
                                    EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                                )
                                .frame(width: 25.16, height: 25.16)
                        }
                        
                        
                    }
                    .background(
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 310, height: 40)
                            .background(.black)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .inset(by: -1)
                                    .stroke(.white, lineWidth: 2)
                            )
                    )
                    .position(x: UIScreen.main.bounds.width / 2 - 14, y: 100);
                
                }.padding(.horizontal)
                
                Rectangle()
                    .frame(width:5, height: 71)
                    .opacity(0)

                

                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }
        .onTapGesture {
            dismissKeyboard()
        }
    }
    private func dismissKeyboard() {
         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    
}

 
 /*

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



*/

#Preview {
    ContentView()
}



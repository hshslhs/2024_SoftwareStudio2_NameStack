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
    @State private var showLooping = true
    @State private var isEditing = false
    @State private var checkArray = [false]

    var body: some View {
        ZStack() {
            Color.black.ignoresSafeArea(.all)
            if(showLooping){
                LoopingScrollView()
                    .padding(.bottom, 30)
            }

            
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
                ZStack(){
                    if(!showLooping){
                        Rectangle()
                            .frame(width:310, height: 417)
                            .foregroundColor(Color(UIColor(red: 0xFF/255, green: 0xFF/255, blue: 0xFF/255, alpha: 1.0)))
                            .opacity(0.06)
                        ScrollView(.vertical){
                            VStack(){
                                Rectangle()
                                    .frame(width: 310, height: 100)
                                HStack(){
                                    ZStack() {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 260, height: 25)
                                            .background(Color(red: 0.07, green: 0.44, blue: 0.85).opacity(0.53))
                                            .cornerRadius(6)
                                            .offset(x: 0, y: 0)
                                        Text("한양대")
                                            .font(Font.custom("Urbanist", size: 15).weight(.bold))
                                            .foregroundColor(.white)
                                            .offset(x: -0.01, y: 0.50)
                                    }
                                    .frame(width: 260, height: 25)
                                    
                                    Button(action: {
                                        checkArray[0] = !checkArray[0]
                                    }){
                                        if(!checkArray[0]){
                                            Image("uncheck")
                                        }else{
                                            Image("checkfill")
                                        }
                                    }
                                }
                                
                            }
                            
                        }.frame(width: 290, height: 400)
                    }
                    
                    HStack(){
                        
                        TextField("Search..", text : $mainSearchText, onEditingChanged: {
                            editing in isEditing = editing
                            if editing{
                                showLooping = false
                                isTabBarVisible = false
                            }
                        })
                                .font(Font.custom("Urbanist", size: 18))
                                .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                                .frame(width: 229, height: 30)
                                
                                
                        
                        Spacer() .frame(width: 5)

                        Button(action: {
                            mainSearchText = "" // Clear search text
                            print("eraseAll")
                        }) {
                            Image("eraseAll")
                                .foregroundColor(.gray)
                        }
                        Spacer() .frame(width: 11)
                        
                        Button(action: {
                            showLooping = true
                            isTabBarVisible=true
                            dismissKeyboard()
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
                    //.background(.red)

                

                
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


#Preview {
    ContentView()
}



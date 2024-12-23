//
//  MainScreen.swift
//  NameStack
//
//  Created by 이현서 on 11/5/24.
//
import SwiftUI
import UIKit
import SwiftData

struct MainScreen: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path:NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int

    
    @State private var showHomeButton = false
    @State private var mainSearchText: String = ""
    @State private var showLooping = true
    @State private var isEditing = false
    @State private var checkArray: [UUID:Bool] = [:]

    @Query(sort: \NameTag.name, order: .forward) private var tags: [NameTag]
    let paletteColors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple, .brown, .gray]
    
    


    var body: some View {
        ZStack() {
            Color.black.ignoresSafeArea(.all)
            if(showLooping){
                LoopingScrollView(searchText: mainSearchText, searchTag: checkArray, path: $path)
                    .padding(.bottom, 30)
            }
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
            ZStack(){
                
                    
                
                ZStack(){
                    if(!showLooping){
                        Rectangle()
                            .frame(width:310, height: 417)
                            .foregroundColor(Color(UIColor(red: 0xFF/255, green: 0xFF/255, blue: 0xFF/255, alpha: 1.0)))
                            .opacity(0.06)
                        ScrollView(.vertical){
                            ForEach(tags) { tag in
                                VStack(spacing: 20){
                                    HStack(){
                                        ZStack() {
                                            Rectangle()
                                                .foregroundColor(paletteColors[tag.colorIndex].opacity(0.2))
                                                .frame(width: 260, height: 25)
                                                .cornerRadius(6)
                                            Text(tag.name)
                                                .font(Font.custom("Urbanist", size: 15).weight(.bold))
                                                .foregroundColor(.white)
                                        }
                                        
                                        Button(action: {
                                            //명함의 태그 별 ox 여부 체크
                                            checkArray[tag.id]! = !checkArray[tag.id]!
                                        }){
                                            if(!(checkArray[tag.id] ?? false)){
                                                Image("uncheck")
                                            }else{
                                                Image("checkfill")
                                            }
                                        }
                                    }
                                    
                                }
                                
                            }.frame(width: 290, height: 400)
                        }
                    }
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
                    .onSubmit {
                        // Trigger the same action as tapping the search button
                        showLooping = true
                        isTabBarVisible = true
                        dismissKeyboard()
                        print("Search triggered with Enter key")
                        LoopingScrollView(searchText: mainSearchText, searchTag: checkArray, path: $path)
                            .padding(.bottom, 30)
                    }
                    
                    
                    
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
                        LoopingScrollView(searchText: mainSearchText, searchTag: checkArray, path: $path)
                            .padding(.bottom, 30)
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
                .position(x: UIScreen.main.bounds.width / 2 - 19, y: 100)
                    
            }.padding(.horizontal)
                
                Rectangle()
                    .frame(width:5, height: 71)
                    .opacity(0)
                //.background(.red)
                
                
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onTapGesture {
                    dismissKeyboard()
                }
                .onAppear{initializeCheckArray()}
            
            
    }
    
    
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    /*
    private func loadData() {
        for tag in tags{
            print(checkTag)
            if(thisCard.tags.contains(tag)){
                checkTag.updateValue(true, forKey: tag.id)
            }
            else{
                checkTag.updateValue(false, forKey: tag.id)
            }
        }
    }
    private func saveData(){
        for tag in tags{
            print(checkTag)
            if(checkTag[tag.id]! && !thisCard.tags.contains(tag)){
                thisCard.tags.append(tag)
            }
            else if(!checkTag[tag.id]! && thisCard.tags.contains(tag)){
                if let index = thisCard.tags.firstIndex(of: tag) {
                    thisCard.tags.remove(at: index)
                }
            }
        }
    }
     */
    private func initializeCheckArray(){
        for tag in tags{
            checkArray[tag.id] = false
        }
    }
    
}


#Preview {
    ContentView()
}



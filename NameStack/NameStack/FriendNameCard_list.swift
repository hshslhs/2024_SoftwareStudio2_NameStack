//
//  NameStack_friendsApp.swift
//  NameStack_friends
//
//  Created by 이현서 on 11/6/24.
//

import SwiftUI
import UIKit
import SwiftData

struct FriendNameCard_list: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    @Environment(\.modelContext) private var modelContext
    private let cardID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    
    @Query private var allCards: [Card]
    
    var cards: [Card] {
        allCards.filter { $0.id != cardID && isSearchedCard(card: $0)}
    }
    
    @State private var searchText: String = ""

    var body: some View {
        ZStack() {
            Color.black.edgesIgnoringSafeArea(.all)
            Button(action: {
                dismissKeyboard()
                isSidebarVisible.toggle()
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
            
            Button(action: {
                path = NavigationPath()
                selectedTab = 0
                isTabBarVisible=true
            }) {
                Image("Home")
                    .padding(
                        EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                    )
            }
            .frame(width: 30, height: 30)
            .position(x: UIScreen.main.bounds.width-50, y: 20);
            
            VStack(){
                Spacer() .frame(height: 90)
                HStack(){
                    Spacer() .frame(width: 5)
                    HStack(){
                        
                        TextField("Search", text: $searchText)
                            .font(Font.custom("Urbanist", size: 18))
                            .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                            .frame(width: 229, height: 22)
                            .offset(x:10)
                            .onTapGesture {
                                searchText = ""
                            }
                        Spacer() .frame(width: 5)
                        
                        Button(action: {
                            searchText = "" // Clear search text
                        }) {
                            Image("eraseAll")
                                .foregroundColor(.gray)
                        }
                        Spacer() .frame(width: 11)
                        Button(action: {
                            //getSearchCard()
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
                    Spacer() .frame(width: 30)
                    Button(action: {
                        
                        withAnimation{ path.append(MainDestination.edit(UUID()))}
                    }){
                        Image("plus")
                            .alignmentGuide(.trailing) { d in d[.trailing] - 50 }
                    }
                }.padding(.horizontal)
                
                
                ScrollView{
                    ForEach(cards) { namecard in
                        VStack(spacing: 15){
                            ZStack() {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 330, height: 93)
                                    .cornerRadius(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .inset(by: 0.50)
                                            .stroke(.white, lineWidth: 2)
                                    )
                                Text(namecard.name)
                                    .font(Font.custom("Urbanist", size: 25).weight(.semibold))
                                    .foregroundColor(.white)
                                    .offset(x: -110.50, y: -14.50)
                                
                                Text(namecard.organization)
                                    .font(Font.custom("Urbanist", size: 16).weight(.light))
                                    .foregroundColor(.white)
                                    .offset(x: -69, y: 18)
                                
                                HStack(){
                                    Button(action: {
                                        withAnimation{path.append(MainDestination.edit(namecard.id))}
                                    }) {
                                        Image("Arrow2")
                                            .foregroundColor(.white)
                                            .padding(
                                                EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                                            )
                                            .frame(width: 25.16, height: 25.16)
                                    }
                                }.padding(.leading, 280)
                            }
                            .padding(.top, 20)
                            .frame(width: 330, height: 93)
                            
                        }.padding(.vertical)
                    }
                    .offset(x:0, y:43)
                }
            }.onTapGesture{dismissKeyboard()}
            
                .navigationBarBackButtonHidden(true)
        }
    }
    private func dismissKeyboard() {
         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    func getSearchCard(){
       // cards = allCards.filter { $0.id != cardID && isSearchedCard(card: $0)}
    }
    func isSearchedCard(card: Card) -> Bool {
        var retText = false
        if(card.name.lowercased().contains(searchText.lowercased())){
            retText = true
        }
        else if(card.phoneNumber.lowercased().contains(searchText.lowercased())){
            retText = true
        }
        else if(card.mail.lowercased().contains(searchText.lowercased())){
            retText = true
        }
        else if(card.organization.lowercased().contains(searchText.lowercased())){
            retText = true
        }
        else if(card.school.lowercased().contains(searchText.lowercased())){
            retText = true
        }
        else if(card.URL.lowercased().contains(searchText.lowercased())){
            retText = true
        }
        else if(card.memo.lowercased().contains(searchText.lowercased())){
            retText = true
        }

        if(!searchText.isEmpty){
            return retText
        }
        return true
    }
}
#Preview {
    ContentView()
}


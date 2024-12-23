//
//  ContentView.swift
//  NameStack

//  Created by 이현서 on 11/5/24.
//

import SwiftUI
import UIKit


enum MainDestination: Hashable {
    case categoryTag
    case friendCards
    case settings
    case qrCode(UIImage)
    
    case account
    case updateInfo
    
    case edit(UUID, Bool)
    case editScanned(Card)
    case editTag(UUID)
}

enum TabbedItems: Int, CaseIterable{
    case profile = 1
    case home = 0
    case scan = -1
    
    var title: String{
        switch self {
        case .profile:
            return "Profile"
        case .home:
            return "Home"
        case .scan:
            return "Scan"
            
        }
    }
    
    var iconName: String{
        switch self {
        case .profile:
            return "Profile-png"
        case .home:
            return "Home-png"
        case .scan:
            return "Scan-png"
            
        }
    }
}

struct ContentView: View {
    @State var selectedTab = 0
    @State private var isSidebarVisible = false
    @State private var path = NavigationPath()
    @State private var isTabBarVisible = true
    
    var body: some View {
   
        ZStack(alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            
            NavigationStack(path: $path) {
                TabView(selection: $selectedTab) {
                    
                    MyNameCard(isSidebarVisible: $isSidebarVisible, path: $path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                        .tag(1)
                     
                 
                    MainScreen(isSidebarVisible: $isSidebarVisible, path: $path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                        .tag(0)
              
                    QRScanner(isSidebarVisible: $isSidebarVisible, path: $path, isTabBarVisible: $isTabBarVisible)
                        .tag(-1)
                         
                }
 
                .navigationDestination(for: MainDestination.self) { destination in
                    switch destination {
                    case .categoryTag:
                        CategoryTag(isSidebarVisible: $isSidebarVisible, path: $path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                    case .friendCards:
                        FriendNameCard_list(isSidebarVisible: $isSidebarVisible, path: $path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                    case .settings:
                        Settings(isSidebarVisible: $isSidebarVisible, path: $path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                            .transition(.move(edge: .leading))
                    case .qrCode(let qrImage):
                        QRCode(qrImage: qrImage, path: $path, isTabBarVisible: $isTabBarVisible, selectedTab:$selectedTab)
                        
                    case .account:
                        Account(isSidebarVisible: $isSidebarVisible, path:$path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                    case .updateInfo:
                        UpdateInfo(isSidebarVisible: $isSidebarVisible, path:$path, isTabBarVisible: $isTabBarVisible, selectedTab:$selectedTab) 
                    case .edit(let namecardID, let isNewCard):
                        FriendNameCard_edit(namecardID: namecardID, isNewCard: isNewCard, path:$path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                    case .editScanned(let namecard):
                        ScannedNameCard_edit(thisCard: namecard, path:$path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                    case .editTag(let thisCardId):
                        EditTag(thisCardId: thisCardId ,path:$path, isTabBarVisible: $isTabBarVisible, selectedTab: $selectedTab)
                    }
                    
                        
                }
                
            }
            
            
            if isSidebarVisible {
                SideBar(
                    isSidebarVisible: $isSidebarVisible,
                    path: $path,
                    isTabBarVisible: $isTabBarVisible,
                    selectedTab: $selectedTab
                ) .transition(.move(edge: .leading))
            }
            
            
            if isTabBarVisible{
                ZStack{
                  
                    HStack{
                     
                        ForEach((TabbedItems.allCases), id: \.self){ item in
                            Button{
                                selectedTab = item.rawValue
                                isTabBarVisible = true
                            } label: {
                                CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                            }
                        }
                    }
                    .padding(6)
                }
                .frame(height: 70)
                .background(.gray.opacity(0.2))
                .cornerRadius(35)
                .padding(.horizontal, 50)
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation {
                isTabBarVisible = false//키보드 열렸을 때 탭 바 안 사라지는 문제 해결
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation {
                if((selectedTab == 1||selectedTab==0)&&isSidebarVisible==false){
                    isTabBarVisible = true}//키보드 내려가면 탭 바 다시 생기게. but 사이드바 열릴 때는 탭 바 안 보이게
            }
        }
        
    }
    
    
    
}

extension ContentView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 24, height: 24)
            
            Spacer()
        }
        .frame(width: 90, height: 60)
        .background(isActive ? .white.opacity(1) : .clear)
        
        .cornerRadius(30)
    }
}


#Preview {
    ContentView()
}


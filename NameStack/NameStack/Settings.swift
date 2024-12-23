//
//  SettingsView.swift
//  1107
//
//  Created by 김세연 on 11/7/24.
//

import SwiftUI


/*
enum SettingsDestination: Hashable {
    case account
    case updateInfo
}

*/
struct Settings: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
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
                
                Button(action: {
                    path = NavigationPath()
                    selectedTab = 0// mynamecard, qrscanner가 아닌 mainscreen으로 돌아가기
                    isTabBarVisible=true
                }) {
                    Image("Home")
                        .padding(
                            EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                        )
                }
                .frame(width: 30, height: 30)
                .position(x: UIScreen.main.bounds.width-50, y: 20);

                VStack{
                    Text("최신 버전입니다")
                        .font(Font.custom("Roboto", size: 20).weight(.bold))
                        .foregroundColor(.gray)
                        .padding(.bottom, 2)

                    Text("1.0.0")
                        .font(Font.custom("Roboto", size: 20).weight(.bold))
                        .foregroundColor(.gray)

                }
                
            }
            .navigationBarBackButtonHidden(true)
            
                

            
        
        
        }
    
}

#Preview {
    ContentView()
}

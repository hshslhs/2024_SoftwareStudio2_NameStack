//
//  UpdateInfo.swift
//  NameStack
//
//  Created by 김세연 on 11/7/24.
//


import SwiftUI

struct UpdateInfo: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                withAnimation {
                    //isSidebarVisible.toggle()
                    path.removeLast()
                }
            }) {
                Image("Arrow")
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
                selectedTab = 0//mynamecard, qrscanner가 아닌 mainscreen으로 돌아가기
                isTabBarVisible=true
            }) {
                Image("Home")
                    .padding(
                        EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                    )
            }
            .frame(width: 30, height: 30)
            .position(x: UIScreen.main.bounds.width-50, y: 20);
            
            VStack {

                Spacer()
                
                Text("업데이트 정보 페이지")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}


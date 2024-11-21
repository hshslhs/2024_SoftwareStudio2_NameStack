//
//  SideBar.swift
//  NameStack
//
//  Created by 김세연 on 11/7/24.
//

import SwiftUI

struct SideBar: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
   
            Color.black.edgesIgnoringSafeArea(.all)
            
            Text("NameStack")
                .font(Font.custom("Jura", size: 30).weight(.bold))
                .foregroundColor(.white)
                .frame(width: 175, height: 35)
                .position(x: UIScreen.main.bounds.width / 2, y: 20);
            
            
            VStack {
                Spacer()
                    .frame(height:50)

                Divider()
                    .background(Color.white)

                Button(action: {
                    path.append(MainDestination.categoryTag)
                    isSidebarVisible = false
                    isTabBarVisible = false
                    selectedTab=2//탭 뷰 안 보이게 하기 위한 코드. 필요에 따라 숫자 변경 가능
                }) {
                    Text("분류 태그 관리")
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .padding()
                        .foregroundColor(.white)
                }

                Button(action: {
                    path.append(MainDestination.friendCards)
                    isSidebarVisible = false
                    isTabBarVisible = false
                    selectedTab=2//탭 뷰 안 보이게 하기 위한 코드. 필요에 따라 숫자 변경 가능
                }) {
                    Text("친구 명함 관리")
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .padding()
                        .foregroundColor(.white)
                }

                Button(action: {
                    path.append(MainDestination.settings)
                    isSidebarVisible = false
                    isTabBarVisible = false
                    selectedTab=2//탭 뷰 안 보이게 하기 위한 코드. 필요에 따라 숫자 변경 가능
                }) {
                    Text("설정")
                        .font(.system(size: 30))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .padding()
                        .foregroundColor(.white)
                }

                Spacer()

                // 터치 영역
                Color.clear
                    .contentShape(Rectangle()) // 명확한 터치 영역
                    .onTapGesture {
                        withAnimation {
                            isSidebarVisible = false
                            adjustTabBarVisibility()// 탭 바 상태 조정
                        }
                    }
            }
        
        }    .offset(x: isSidebarVisible ? 0 : -300) // 사이드바 애니메이션
            .animation(.easeInOut, value: isSidebarVisible)
        
    }

    
    private func adjustTabBarVisibility() {
        // 탭 바 상태를 조정
        switch selectedTab {
        case 1, 0, -1:
            isTabBarVisible = true // MyNameCardView, MainScreen, QRScanner에서만 탭 바 보이게 하기
        default:
            isTabBarVisible = false
        }
    }
     
}
 
#Preview {
    ContentView()
}



//
//  QRCode.swift
//  NameStack
//
//  Created by 김세연 on 11/20/24.
//

import SwiftUI

// QR 코드 표시 뷰
struct QRCode: View {
    //  @Binding var qrImage: UIImage?
    var qrImage: UIImage
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(.all)
            
            Button(action: {
                selectedTab=1
                isTabBarVisible=true
                path.removeLast() // MyNameCard로 돌아가기
            }) {
                Image("Arrow")
                    .padding(
                        EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                    )
            } .frame(width: 30, height: 30)
            .position(x: 50, y: 20);
            
            Text("NameStack")
                .font(Font.custom("Jura", size: 30).weight(.bold))
                .foregroundColor(.white)
                .frame(width: 175, height: 35)
                .position(x: UIScreen.main.bounds.width / 2, y: 20);
            
            VStack() {

                Spacer()
                    .frame(height:120)
                
                Text("내 명함 공유하기")
                    .font(
                        Font.custom("Urbanist", size: 23)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 218, height: 60, alignment: .center)
                    .padding()
                
                
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                
                Spacer()
                    .frame(height:30)
                
                Button(action: {
                    // 새로고침 기능이나 원하는 동작 추가
                    print("QR Code 새로고침 버튼 눌림")
                }) {
                    HStack {
                        
                        Text("QR Code 새로고침")
                            .font(
                                Font.custom("Montserrat", size: 14)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 218, height: 24, alignment: .center)
                    }
                    .frame(width: 179, height: 33, alignment: .center)
                    .background(Constants.GraysBlack)
                    .cornerRadius(30)
                    .shadow(color: Color(red: 0.18, green: 0.18, blue: 0.18).opacity(0.15), radius: 7.5, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .inset(by: 0.5)
                            .stroke(.white, lineWidth: 1)
                    )
                }
                Spacer()
                
            }
            
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}

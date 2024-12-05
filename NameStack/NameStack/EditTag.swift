//
//  EditTag.swift
//  NameStack
//
//  Created by 이현서 on 12/3/24.
//


import SwiftUI
import CoreImage.CIFilterBuiltins
import SwiftData

struct EditTag: View {

    var thisCard: Card
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    @Environment(\.modelContext) private var modelContext

    @Query private var tags: [NameTag]
    
    private let context = CIContext()
    private let qrFilter = CIFilter.qrCodeGenerator()
    private let colorFilter = CIFilter.falseColor()
    @State private var checkTag = [false]

        
    var body: some View {
        
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    path.removeLast()
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
                
                VStack(spacing: 20) {
                    
                    Spacer()
                        .frame(height:70)
                    
                    ScrollView{
                        VStack(spacing: 20){
                                HStack(){
                                    ZStack() {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 260, height: 25)
                                            .background(Color(red: 0.07, green: 0.44, blue: 0.85).opacity(0.53))
                                            .cornerRadius(6)
                                        Text("한양대")
                                            .font(Font.custom("Urbanist", size: 15).weight(.bold))
                                            .foregroundColor(.white)
                                    }
                                    
                                    Button(action: {
                                        checkTag[0] = !checkTag[0]
                                    }){
                                        if(!checkTag[0]){
                                            Image("uncheck")
                                        }else{
                                            Image("checkfill")
                                        }
                                    }
                                }

                            }
                            
                        }.frame(width: 350, height: 600)
                        
                        
                        // Save Button
                        Button(action: {
                            // Action for save button
                        }) {
                            Text("저장")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                }
            .navigationBarBackButtonHidden(true)

            }   //.onAppear(perform: loadData) //
                //.navigationBarBackButtonHidden(true)
                /*.onTapGesture {
                    dismissKeyboard()// 키보드 밖 공간 눌렀을 때 키보드 닫기
                }*/
            
            /*
                .navigationDestination(for: UIImage.self) { qrImage in
                    QRCode(qrImage: qrImage, path:$path) // QRCodeView로 QR 코드 이미지 전달
                }*/
        
        
    }
    private func dismissKeyboard() {
         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    

#Preview {
    ContentView()
}


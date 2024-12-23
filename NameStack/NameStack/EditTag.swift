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

    var thisCardId: UUID
    
    @Query private var allCards: [Card]

    var thisCard: [Card] {
        allCards.filter { $0.id == thisCardId }
    }
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    @State private var showSaveAlert = false
    
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \NameTag.name, order: .forward) private var tags: [NameTag]
    
    private let context = CIContext()
    private let qrFilter = CIFilter.qrCodeGenerator()
    private let colorFilter = CIFilter.falseColor()
    
    let paletteColors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple, .brown, .gray]

    @State private var checkTag: [UUID:Bool] = [:]

        
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
                                        checkTag[tag.id]! = !checkTag[tag.id]!
                                    }){
                                        if(!(checkTag[tag.id] ?? false)){
                                            Image("uncheck")
                                        }else{
                                            Image("checkfill")
                                        }
                                    }
                                }
                            }
                            
                        }.frame(width: 350, height: 600)
                    }
                        
                        
                        // Save Button
                        Button(action: {
                            showSaveAlert=true
                            saveData()
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
            .onAppear(perform: loadData)
            .alert("저장되었습니다", isPresented: $showSaveAlert) { // Alert 표시
                Button("확인", role: .cancel) {}
            }

            }
    private func loadData() {
        for tag in tags{
            print(checkTag)
            if(thisCard[0].tags.contains(tag)){
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
            if(checkTag[tag.id]! && !thisCard[0].tags.contains(tag)){
                thisCard[0].tags.append(tag)
            }
            else if(!checkTag[tag.id]! && thisCard[0].tags.contains(tag)){
                if let index = thisCard[0].tags.firstIndex(of: tag) {
                    thisCard[0].tags.remove(at: index)
                }
            }
        }
    }
    
    
    // //
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


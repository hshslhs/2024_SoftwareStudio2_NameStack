//
//  MyNameCardView.swift
//  1107
//
//  Created by 김세연 on 11/7/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import SwiftData


struct Constants {
    static let GraysBlack: Color = .black
}

struct MyNameCard: View {
    @Environment(\.modelContext) private var modelContext
    private let cardID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")! // 상수로 선언
    
    @Query private var allCards: [Card]
    
    var cards: [Card] {
        allCards.filter { $0.id == cardID }
    }
    
    @State private var name: String = ""
    @State private var organization: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var school: String = ""
    @State private var url: String = ""
    @State private var memo: String = ""
    
    
    @Binding var isSidebarVisible: Bool
    @Binding var path:NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    @State private var showSaveAlert = false
    
    private let context = CIContext()
    private let qrFilter = CIFilter.qrCodeGenerator()
    private let colorFilter = CIFilter.falseColor()
    
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            
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
            
            Button(action: {
                isTabBarVisible=false//큐알 코드 열릴 때 탭 바 닫기
                selectedTab=2//키보드 올라온 상태에서 큐알 코드 열렸을 때 탭 바 살아있는 문제 해결
                if let qrImage = generateQRCode(from: qrDataString()) {
                    path.append(MainDestination.qrCode(qrImage))
                }
            }) {
                Image("QRCode")
                    .padding(
                        EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                    )
            }
            .frame(width: 20, height: 20)
            .position(x: UIScreen.main.bounds.width-50, y: 20);
            
            
            
            VStack(spacing: 20) {
                Spacer()
                    .frame(height:70)

                
                ScrollView{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 237, height: 377)
                            .background(.white)
                            .cornerRadius(15.43)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.43)
                                    .inset(by: 0.5)
                                    .stroke(Constants.GraysBlack, lineWidth: 1)
                            )
                        HStack{
                            Spacer()
                                .frame(width:10)
                            VStack(alignment: .leading, spacing: 10) {
                                Text(name.isEmpty ? "Your Name" : name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                    .frame(height:40)
                                
                                Text(school.isEmpty ? "Your School" : school)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                
                                Text(phoneNumber.isEmpty ? "Your Phone Number" : phoneNumber)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                
                                
                                Text(email.isEmpty ? "Your Email" : email)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                
                                Spacer()
                                    .frame(height:100)
                                
                                
                            }
                            .padding()
                            Spacer()
                        }
           
                        
                        Text(organization.isEmpty ? "Your Organization" : organization)
                            .font(.footnote)
                            .foregroundColor(.black)
                            .padding(.top,300)
                    }.frame(width:200, height:377)
                        .padding(.bottom,15)
                    
                    VStack(spacing: 15) {
                        CustomTextField(title: "이름", text: $name)
                        CustomTextField(title: "소속", text: $organization)
                        CustomTextField(title: "전화번호", text: $phoneNumber, keyboardType: .phonePad)
                        CustomTextField(title: "이메일", text: $email, keyboardType: .emailAddress)
                        CustomTextField(title: "학교", text: $school)
                        CustomTextField(title: "URL", text: $url, keyboardType: .URL)
                        CustomTextField(title: "메모", text: $memo, isMultiline: true)
                    }
                    .padding(.horizontal)
                    
                    
                    // Save Button
                    Button(action: {
                        showSaveAlert=true
                        saveData()
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
                }.padding(.bottom,30)
                
            }
            
        }
        .onTapGesture {
            dismissKeyboard()// 키보드 밖 공간 눌렀을 때 키보드 닫기
        }
        .onAppear(perform: loadData)
        
        .alert("저장되었습니다", isPresented: $showSaveAlert) { // Alert 표시
            Button("확인", role: .cancel) {}
        }
    }
    
    private func dismissKeyboard() {
         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    
    // QR 코드에 포함될 데이터 문자열
    private func qrDataString() -> String {
        
        """
        Name: \(name)
        Organization: \(organization)
        Phone Number: \(phoneNumber)
        Email: \(email)
        School: \(school)
        URL: \(url)
        Memo: \(memo)
        """
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        qrFilter.message = Data(string.utf8)
        
        if let qrOutputImage = qrFilter.outputImage {
            // 색상 필터 설정: 포어그라운드를 흰색으로, 배경을 검정색으로 설정
            colorFilter.inputImage = qrOutputImage
            colorFilter.color0 = CIColor.white // QR 코드 색상
            colorFilter.color1 = CIColor.black // 배경색
            
            // 이미지 렌더링 및 반환
            if let coloredQRImage = colorFilter.outputImage,
               let cgImage = context.createCGImage(coloredQRImage.transformed(by: CGAffineTransform(scaleX: 1, y: 1)), from: coloredQRImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
    // 데이터 저장 함수
    private func saveData() {
        if(!cards.isEmpty){
            cards[0].name = name
            cards[0].organization = organization
            cards[0].phoneNumber = phoneNumber
            cards[0].mail = email
            cards[0].school = school
            cards[0].URL = url
            cards[0].memo = memo
        }
        else{
            let newCard: Card = Card(id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,name: name, phoneNumber: phoneNumber, mail: email, organization: organization, school: school, URL: url, memo: memo)
            do {
                modelContext.insert(newCard)
            try modelContext.save()
            } catch {
              print("error")
            }
        }
        print("Data saved.")
    }
    
    // 데이터 로드 함수
    private func loadData() {
        if(!cards.isEmpty){
            name = cards[0].name
            organization = cards[0].organization
            phoneNumber = cards[0].phoneNumber
            email = cards[0].mail
            school = cards[0].school
            url = cards[0].URL
            memo = cards[0].memo
        }
        print("Data loaded.")
    }
    
}


struct CustomTextField: View {
    var title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isMultiline: Bool = false
    
    var body: some View {
        if isMultiline {
            
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black) // 검정색 배경
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1) // 흰색 테두리
                    )
                
                VStack{
                    HStack{
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.gray) // 위에 작은 타이틀
                            .padding(.leading,15)
                        Spacer()
                    }.padding(.top,10)
                    TextEditor(text: $text)
                        .frame(height: 100)
                        .padding(.horizontal, 10)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }
            }
        } else {
            ZStack{
                RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1)
                VStack{
                    HStack{
                        Text(title)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.leading,15)
                        Spacer()
                    }.padding(.top,10)
                    TextField(title, text: $text)
                        .keyboardType(keyboardType)
                        .padding(.leading,15)
                        .padding(.trailing, 15)
                        .padding(.bottom,10)
                    
                        .background(Color.black.opacity(0.1))
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                    
                }
                
            }
        }
    }
}

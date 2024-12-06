//
//  MyNameCardView.swift
//  1107
//
//  Created by 김세연 on 11/7/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import SwiftData

/*
struct Constants {
  static let GraysBlack: Color = .black
}
*/
struct ScannedNameCard_edit: View {
    @Environment(\.modelContext) private var modelContext
    
    var thisCard: Card
    //var thisCard: Card
        
    @State private var name: String = ""
    @State private var organization: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var school: String = ""
    @State private var url: String = ""
    @State private var memo: String = ""

    
   // @State private var path = NavigationPath()
    
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int

    //@Environment(\.dismiss) var dismiss // 모달을 닫기 위한 환경 변수

    
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
                            //      .padding(.trailing, 40)
                            
                            Text(organization.isEmpty ? "Your Organization" : organization)
                                .font(.footnote)
                                .foregroundColor(.black)
                                .padding(.top,300)
                        }.frame(width:200, height:377)
                            .padding(.bottom,15)
                        
                        VStack(spacing: 15) {
                            Button(action:{
                                withAnimation{ path.append(MainDestination.editTag(thisCard))}
                            }){
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 89, height: 25)
                                        .cornerRadius(4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .inset(by: 0.5)
                                                .stroke(.white, lineWidth: 1)
                                        )
                                    
                                    
                                    
                                    HStack{
                                        
                                        Image("Tag")
                                            .frame(width: 14, height: 14)
                                        
                                        Text("태그 편집")
                                            .font(Font.custom("Roboto", size: 11))
                                            .kerning(0.25)
                                            .foregroundColor(.white)
                                        
                                        
                                    }
                                    
                                }.padding(.bottom, 10)
                            }
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
                    }
                }
            }   .onAppear(perform: loadData) //
                .navigationBarBackButtonHidden(true)
                .onTapGesture {
                    dismissKeyboard()// 키보드 밖 공간 눌렀을 때 키보드 닫기
                }

        
        
    }
    private func dismissKeyboard() {
         UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    
    // 데이터 저장 함수
    private func saveData() {
        thisCard.name = name
        thisCard.organization = organization
        thisCard.phoneNumber = phoneNumber
        thisCard.mail = email
        thisCard.school = school
        thisCard.URL = url
        thisCard.memo = memo
        do {
            modelContext.insert(thisCard)
        try modelContext.save()
        } catch {
          //print("error")
        }
        //print("Data saved.")
    }

    // 데이터 로드 함수
    private func loadData() {
        name = thisCard.name
        organization = thisCard.organization
        phoneNumber = thisCard.phoneNumber
        email = thisCard.mail
        school = thisCard.school
        url = thisCard.URL
        memo = thisCard.memo
        //print("Data loaded.")
    }
    
}

#Preview {
    ContentView()
}


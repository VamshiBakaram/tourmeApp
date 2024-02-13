//
//  OnboardingView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 1/15/22.
//

import SwiftUI
import FlagKit
import FloatingLabelTextFieldSwiftUI

struct OnboardingView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var userPreferencesStore: UserPreferencesStore
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode

    
    var isFromSettings = false
    
    var body: some View {
        
        VStack {
            if currentPage == 1 {
                InitialScreenView(bgColor: Color("PrimaryColor2"), isFromSettings: isFromSettings)
                    .transition(.scale)
            }
            if currentPage == 2 {
                ScreenView(image: "onboard2", title: "dont_blink".localized(userLanguage), detail: "you_dont_want_to_miss_this".localized(userLanguage), bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            if currentPage == 3 {
                ScreenView(image: "Thank you background", title: "onboarding_thank_you".localized(userLanguage), detail: "onboarding_your_ticket_to_the_holy_land".localized(userLanguage), bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
//            if currentPage == 4 {
//                ScreenView(image: "en_gedi_israel", title: "onboarding_get_started_title".localized(userLanguage), detail: "onboarding_get_started_detail".localized(userLanguage), bgColor: Color("PrimaryColor2"))
//                    .transition(.scale)
//            }
           // if currentPage == 4 {
               // UserProfileScreenView(image: "en_gedi_israel", title: "onboarding_user_profile_title".localized(userLanguage), detail: "May we have some Information?", bgColor: Color("PrimaryColor2"))
                //    .transition(.scale)
           // }
        }
        .overlay(
            HStack {
//                if currentPage == 3 {
//                    Button(action: {
//                        withAnimation(.easeInOut) {
//                            currentPage -= 1
//                        }
//                    }) {
//                        Text("Previous")
//                            .font(.custom(.inriaSansRegular, size: 18))
//                            .foregroundColor(.white)
//                            .frame(maxWidth: 180)
//                            .frame(height: 50)
//                            .padding()
//                    }
//                    .padding(.bottom, 20)
//                    Spacer()
//                }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        if currentPage < totalPages {
                            if currentPage == 1  {
                                if isFromSettings {
                                    presentationMode.wrappedValue.dismiss()
                                }else{
                                    currentPage = 3
                                }
                            }else{
                                if isFromSettings {
                                    presentationMode.wrappedValue.dismiss()
                                }else{
                                    currentPage = 3
                                }
                                showOnboarding = false
                            }
                        } else {
                            if isFromSettings {
                                presentationMode.wrappedValue.dismiss()
                            }else{
                                showOnboarding = false

                            }
                        }
                    }
                }, label: {
                    if isFromSettings {
                        Text("Save")
                            .font(.custom(.inriaSansRegular, size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.buttonThemeColor)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding()
                    }else{
                        Text(currentPage == 4 ? "Finish".localized(userLanguage) : "Next".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.buttonThemeColor)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding()
                    }
                })
                .padding(.bottom, 20)
            }
            , alignment: .bottom
        )
        .onAppear {
            if isFromSettings {
                currentPage = 1
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct ScreenView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    var canSkip: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Welcome to\nTourMeApp".localized(userLanguage))
                .foregroundColor(.white)
                .font(.custom(.inriaSansBold, size: 44))
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)
            Text("Let your Holy Land adventure begin".localized(userLanguage))
                .foregroundColor(.white)
                .font(.custom(.inriaSansBold, size: 18))
                .fontWeight(.bold)
                .kerning(0.36)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(
            Image(image)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
        )
    }
}

struct ChooseLanguage {
    let headerImageName: String
    let languageName: String
    let selectedIconName = "icon-park"
    var isSelected = false
}

struct InitialScreenView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    var bgColor: Color
    var isFromSettings = false
    
    @State private var languageItems: [ChooseLanguage] = [
        .init(headerImageName: "usa_flag", languageName: "English"),
        .init(headerImageName: "spain_flag", languageName: "Spanish"),
        .init(headerImageName: "brasil_flag", languageName: "Portuguese")
    ]
    
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 30) {
                Spacer()
                Text(isFromSettings ? "Change\nLanguage" : "settings_choose_language".localized(userLanguage))
                    .font(.custom(.inriaSansBold, size: 44))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                LazyVGrid(columns: reader.size.width < 450 ? Array(repeating: GridItem(.flexible(minimum: 0, maximum: 300)), count: 2) : Array(repeating: GridItem(.flexible(minimum: 0, maximum: 300)), count: 3), content: {
                    ForEach(0..<languageItems.count, id: \.self) { index in
                        VStack(spacing: 10) {
                            Image(languageItems[index].headerImageName)
                            Text(languageItems[index].languageName)
                                .font(.custom("InriaSans-Regular", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            if languageItems[index].isSelected {
                                Image("icon-park")
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: languageItems[index].isSelected ? 10 : 0)
                                .stroke(Color(red: 0.02, green: 0.62, blue: 0.85), lineWidth: languageItems[index].isSelected ? 2 : 0)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: languageItems[index].isSelected ? 10 : 0))
                        .padding()
                        .gesture(
                            TapGesture()
                                .onEnded({
                                    for index in 0..<languageItems.count {
                                        self.languageItems[index].isSelected = false
                                    }
                                    self.languageItems[index].isSelected = true
                                    if self.languageItems.first?.isSelected ?? false {
                                        userLanguage = .en
                                    }else if self.languageItems[1].isSelected {
                                        userLanguage = .es
                                    }else if self.languageItems.last?.isSelected ?? false{
                                        userLanguage = .pt
                                    }else{
                                        userLanguage = .en
                                    }
                                })
                        )
                    }
                }).padding()
                Spacer()
            }
            .padding()
        }
        .onAppear {
            if isFromSettings {
                if userLanguage == .en {
                    languageItems[0].isSelected = true
                }else if userLanguage == .es {
                    languageItems[1].isSelected = true
                }else if userLanguage == .pt {
                    languageItems[2].isSelected = true
                }
            }
        }
////            HStack {
////                if currentPage == 1 {
////                    Text("onboarding_welcome".localized(userLanguage))
////                        .font(.title)
////                        .fontWeight(.semibold)
////                        .kerning(1.4)
////                } else {
////                    Button(action: {
////                        withAnimation(.easeInOut) {
////                            currentPage -= 1
////                        }
////                    }) {
////                        Image(systemName: "chevron.left")
////                            .foregroundColor(.white)
////                            .padding(.vertical, 10)
////                            .padding(.horizontal)
////                            .background(Color.black.opacity(0.4))
////                            .cornerRadius(10)
////                    }
////                }
////
////
////
////                Spacer()
////
////                Button(action: {
////
////                    showOnboarding = false
////                }, label: {
////                    Text("onboarding_skip".localized(userLanguage))
////                        .fontWeight(.semibold)
////                        .kerning(1.2)
////                })
////            }
////            .foregroundColor(.white)
////            .padding()
////
////            Spacer(minLength: 0)
////
////            Image("tourmeapplogo")
////                .resizable()
////                .aspectRatio(contentMode: .fit)
////                .shadow(color: .white, radius: 30)
////                .shadow(color: .white, radius: 30)
////                .shadow(color: .white, radius: 30)
////                .padding(10)
////
////            Text("settings_choose_language".localized(userLanguage))
////                .font(.title)
////                .fontWeight(.bold)
////                .foregroundColor(.white)
////                .padding(.top)
////
////            Picker("settings_choose_language".localized(userLanguage), selection: $userLanguage) {
////                Image("US", bundle: FlagKit.assetBundle).tag(Language.en)
////                Image("ES", bundle: FlagKit.assetBundle).tag(Language.es)
////                Image("BR", bundle: FlagKit.assetBundle).tag(Language.pt)
////            }.pickerStyle(.segmented)
////                .padding(.horizontal, 30)
////
////            Spacer(minLength: 120)
//        }
        //.background(bgColor.ignoresSafeArea())
    }
}

import ToastSwiftUI

struct UserProfileScreenView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var userPreferencesStore: UserPreferencesStore
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
        
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    @AppStorage("email") var userEmail = ""
    @AppStorage("phone") var userPhone = ""
    @AppStorage("displayName") var userDisplayName = ""
    
    @EnvironmentObject var sessionManager: SessionManager

    
    @State var email = ""
    @State var phone = ""
    @State var displayName = ""
    
    @State var message: String?
    
    @State var isLoading = false
    @State var error: Error?
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    var canSkip: Bool = false
    let emailFromSignUp: String?
    let displayNameFromSignUp: String?
    var isFromSettings: Bool
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            HStack {
                Spacer()
                ZStack {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 183, height: 200)
                      .background(Color(red: 0.02, green: 0.41, blue: 0.56))
                      .cornerRadius(31)
                      .shadow(color: .black.opacity(0.15), radius: 5, x: -4, y: 4)
                      .rotationEffect(Angle(degrees: 14.83))
                      .offset(x: 20)
                      .offset(y: -40)
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 170, height: 170)
                      .background(.white)
                      .cornerRadius(26)
                      .shadow(color: .black.opacity(0.15), radius: 5, x: -4, y: 4)
                      .rotationEffect(Angle(degrees: -17.67))
                      .offset(y: 15)
                      .offset(x: 60)
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 148, height: 148)
                      .background(Color(red: 0.02, green: 0.62, blue: 0.85))
                      .cornerRadius(26)
                      .shadow(color: .black.opacity(0.15), radius: 5, x: -4, y: 4)
                      .rotationEffect(Angle(degrees: 15.07))
                      .offset(y: 120)
                      .offset(x: 125)

                    
                }
            }
            VStack(alignment: .leading, spacing: 16, content: {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .font(.custom(.inriaSansBold, size: 40))
                    .padding(.top)
                Text(detail)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .font(.custom(.inriaSansRegular, size: 16))
            }).padding()
                .offset(y: -120)
            VStack(spacing: 16) {
                FloatingLabelTextField($displayName, placeholder: "onboarding_display_name".localized(userLanguage))
                    .leftView {
                        Image("user")
                    }
                    .textColor(.primary)
                    .titleColor(.primary)
                    .selectedLineColor(.primary)
                    .selectedTextColor(.primary)
                    .selectedTitleColor(.primary)
                    .frame(height: 50)
                FloatingLabelTextField($email, placeholder: "onboarding_email".localized(userLanguage))
                    .leftView {
                        Image("mail")
                    }
                    .textColor(.primary)
                    .titleColor(.primary)
                    .selectedLineColor(.primary)
                    .selectedTextColor(.primary)
                    .selectedTitleColor(.primary)
                    .frame(height: 50)
                    .keyboardType(.emailAddress)
                FloatingLabelTextField($phone, placeholder: "onboarding_phone".localized(userLanguage))
                    .leftView {
                        Image("phone")
                    }
                    .textColor(.primary)
                    .titleColor(.primary)
                    .selectedLineColor(.primary)
                    .selectedTextColor(.primary)
                    .selectedTitleColor(.primary)
                    .frame(height: 50)
                    .keyboardType(.phonePad)
            }
            .padding(.horizontal, 20)
            .offset(y: -80)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
        .ignoresSafeArea()
        .overlay(
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut) {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        if isFromSettings {
                            updateProfile()
                        }else{
                            self.sessionManager.authManager = "home"
                        }
                    }
                }, label: {
                    Text(isFromSettings ? "Update" : "Finish".localized(userLanguage))
                        .font(.custom(.inriaSansRegular, size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.buttonThemeColor)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding()
                })
                .padding(.bottom, 20)
            }
            , alignment: .bottom
        )
        .toast($message)
        .onAppear(perform: {
            self.email = emailFromSignUp ?? ""
            self.displayName = displayNameFromSignUp ?? ""
            if isFromSettings {
                self.email = sessionManager.email
                self.displayName = sessionManager.displayName
                self.phone = sessionManager.phone
            }
        })
        .onDisappear {
            userDisplayName = displayName
            sessionManager.phone = phone

        }
    }
    
    func updateProfile() {
        self.isLoading = true
        let parameters = UpdateProfile(email: email, familyName: sessionManager.familyName , id: sessionManager.userId ?? "", phoneNumber: phone, userName: displayName)
        NetworkManager.shared.request(type: ResetPasswordModel.self, url: API.updateProfile, httpMethod: .post, parameters: parameters) { result in
            self.message = "Profile updated successfully"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                sessionManager.email = email
                sessionManager.phone = phone
                sessionManager.displayName = displayName
                userDisplayName = displayName
                self.isLoading = false
                presentationMode.wrappedValue.dismiss()
            })
        }
        
    }
    
    func saveProfileData() {
        if userEmail.isEmpty && userPhone.isEmpty && userDisplayName.isEmpty {
            if !email.isEmpty || !phone.isEmpty || !displayName.isEmpty {
                userEmail = email
                userPhone = phone
                userDisplayName = displayName
                
                userPreferencesStore.saveUserProfile(email: email, phone: phone, displayName: displayName) { result, error in
                    print("user profile created")
                }
            }
        }
    }
}

var totalPages = 4

struct UpdateProfile: Encodable {
    let email: String
    let familyName: String
    let id: String
    let phoneNumber: String
    let userName: String
}

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
    
    var body: some View {
        VStack {
            if currentPage == 1 {
                InitialScreenView(bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            if currentPage == 2 {
                ScreenView(image: "onboard2", title: "dont_blink".localized(userLanguage), detail: "you_dont_want_to_miss_this".localized(userLanguage), bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            if currentPage == 3 {
                ScreenView(image: "gardenTomb", title: "onboarding_thank_you".localized(userLanguage), detail: "onboarding_your_ticket_to_the_holy_land".localized(userLanguage), bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
//            if currentPage == 4 {
//                ScreenView(image: "en_gedi_israel", title: "onboarding_get_started_title".localized(userLanguage), detail: "onboarding_get_started_detail".localized(userLanguage), bgColor: Color("PrimaryColor2"))
//                    .transition(.scale)
//            }
            if currentPage == 4 {
                UserProfileScreenView(image: "en_gedi_israel", title: "onboarding_user_profile_title".localized(userLanguage), detail: "May we have some Information?", bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
        }
        .overlay(
            HStack {
                if currentPage == 3 {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            currentPage -= 1
                        }
                    }) {
                        Text("Previous")
                            .font(.custom(.inriaSansRegular, size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: 180)
                            .frame(height: 50)
                            .padding()
                    }
                    .padding(.bottom, 20)
                    Spacer()
                }
                if currentPage == 2 {
                    Spacer()
                }
                Button(action: {
                    withAnimation(.easeInOut) {
                        if currentPage < totalPages {
                            currentPage += 1
                        } else {
                            showOnboarding = false
                        }
                    }
                }, label: {
                    Text(currentPage == 4 ? "Finish" : "Next")
                        .font(.custom(.inriaSansRegular, size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: (currentPage == 1 || currentPage == 4) ? .infinity : 180)
                        .frame(height: 50)
                        .background(Color.buttonThemeColor)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding()
                })
                .padding(.bottom, 20)
            }
            , alignment: .bottom
        )
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
            HStack {
                Spacer()
                if canSkip {
                    Button(action: {
                        showOnboarding = false
                    }, label: {
                        Text("onboarding_skip".localized(userLanguage))
                            .fontWeight(.semibold)
                            .kerning(1.2)
                    })
                }
            }
            .padding()
            Text(title)
                .font(.custom(.inriaSansBold, size: 36))
                .padding(.top)
            Text(detail)
                .font(.custom(.inriaSansBold, size: 16))
                .fontWeight(.bold)
                .frame(width: currentPage == 2 ? 120 : 230)
                .multilineTextAlignment(.center)
            Spacer()
        }
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
    
    @State private var languageItems: [ChooseLanguage] = [
        .init(headerImageName: "usa_flag", languageName: "English"),
        .init(headerImageName: "spain_flag", languageName: "Portugese"),
        .init(headerImageName: "brasil_flag", languageName: "English")
    ]
    
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 30) {
                Spacer()
                Text("settings_choose_language".localized(userLanguage))
                    .font(.custom(.inriaSansBold, size: 36))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                LazyVGrid(columns: reader.size.width < 450 ? Array(repeating: GridItem(.flexible(minimum: 0, maximum: 300)), count: 2) : Array(repeating: GridItem(.flexible(minimum: 0, maximum: 300)), count: 3), content: {
                    ForEach(0..<languageItems.count, id: \.self) { index in
                        VStack(spacing: 10) {
                            Image(languageItems[index].headerImageName)
                            Text(languageItems[index].languageName)
                                .font(.custom("InriaSans-Regular", size: 18))
                                .foregroundColor(.black)
                            if languageItems[index].isSelected {
                                Image("icon-park")
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: languageItems[index].isSelected ? 10 : 0)
                                .stroke(Color.black, lineWidth: languageItems[index].isSelected ? 2 : 0)
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
                                })
                        )
                    }
                }).padding()
                Spacer()
            }
            .padding()
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

struct UserProfileScreenView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var userPreferencesStore: UserPreferencesStore
    
    @ObservedObject var keyboardResponder = KeyboardResponder()
        
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    @AppStorage("email") var userEmail = ""
    @AppStorage("phone") var userPhone = ""
    @AppStorage("displayName") var userDisplayName = ""
    
    
    @State var email = ""
    @State var phone = ""
    @State var displayName = ""
    
    @State var isLoading = false
    @State var error: Error?
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    var canSkip: Bool = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            
//            HStack {
//                
//                if currentPage == 1 {
//                    
//                    Text("onboarding_welcome".localized(userLanguage))
//                        .font(.title)
//                        .fontWeight(.semibold)
//                        .kerning(1.4)
//                } else {
//                    
//                    Button(action: {
//                        // changing views...
//                        withAnimation(.easeInOut) {
//                            
//                            currentPage -= 1
//                        }
//                    }) {
//                        
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.white)
//                            .padding(.vertical, 10)
//                            .padding(.horizontal)
//                            .background(Color.black.opacity(0.4))
//                            .cornerRadius(10)
//                    }
//                }
//                
//                Spacer()
//                
//                if canSkip {
//                    Button(action: {
//                        
//                        showOnboarding = false
//                    }, label: {
//                        Text("onboarding_skip".localized(userLanguage))
//                            .fontWeight(.semibold)
//                            .kerning(1.2)
//                    })
//                }
//            }
//            .padding()
            
            //Spacer(minLength: 0)
            
            //LottieView(name: "profile3", loopMode: .loop)
               // .frame(width: 200, height: 200)
            /*
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(10)
             */
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
                    .font(.custom(.inriaSansBold, size: 36))
                    .padding(.top)
                Text(detail)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                    .font(.custom(.inriaSansRegular, size: 14))
            }).padding()
                .offset(y: -120)
            Group {
                FloatingLabelTextField($displayName, placeholder: "onboarding_display_name".localized(userLanguage))
                    .leftView {
                        Image("user")
                    }
                    .foregroundColor(.primary)
                    .frame(height: 50)
                FloatingLabelTextField($email, placeholder: "onboarding_email".localized(userLanguage))
                    .leftView {
                        Image("mail")
                    }
                    .frame(height: 50)
                    .keyboardType(.emailAddress)
                FloatingLabelTextField($phone, placeholder: "onboarding_phone".localized(userLanguage))
                    .leftView {
                        Image("phone")
                    }
                    .frame(height: 50)
                    .keyboardType(.phonePad)
//                TextField("onboarding_email".localized(userLanguage), text: $email)
//                    .pretty()
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                TextField("onboarding_phone".localized(userLanguage), text: $phone)
//                    .pretty()
//                    .keyboardType(.phonePad)
//                    .autocapitalization(.none)
//                TextField("onboarding_display_name".localized(userLanguage), text: $displayName)
//                    .pretty()
//                    .keyboardType(.default)
//                    .autocapitalization(.words)
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
        .onDisappear {
            userDisplayName = displayName
            //saveProfileData()
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

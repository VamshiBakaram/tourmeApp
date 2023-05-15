//
//  OnboardingView.swift
//  tourmeapp (iOS)
//
//  Created by Jonathan Burris on 1/15/22.
//

import SwiftUI
import FlagKit

struct OnboardingView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @EnvironmentObject var userPreferencesStore: UserPreferencesStore
    
    var body: some View {
        
        // For slide animation...
        
        ZStack {
            
            // Changing between views...
            
            if currentPage == 1 {
                
                InitialScreenView(bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            
            if currentPage == 2 {
                
                ScreenView(image: "gardenTomb", title: "onboarding_thank_you".localized(userLanguage), detail: "onboarding_your_ticket_to_the_holy_land".localized(userLanguage), bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            
            if currentPage == 3 {
                
                ScreenView(image: "gethsemane", title: "dont_blink".localized(userLanguage), detail: "you_dont_want_to_miss_this".localized(userLanguage), bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            
            if currentPage == 4 {
                
                ScreenView(image: "en_gedi_israel", title: "onboarding_get_started_title".localized(userLanguage), detail: "onboarding_get_started_detail".localized(userLanguage), bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            
            if currentPage == 5 {
                UserProfileScreenView(image: "en_gedi_israel", title: "onboarding_user_profile_title".localized(userLanguage), detail: "Can we have a little information?", bgColor: Color("PrimaryColor2"))
                    .transition(.scale)
            }
            
        }
        .overlay(
            
            // Button...
            Button(action: {
                
                // changing views...
                withAnimation(.easeInOut) {
                    
                    // checking...
                    if currentPage < totalPages {
                        currentPage += 1
                    } else {
                        ///TODO: save user proflie data
                        showOnboarding = false
                    }
                }
            }, label: {
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                
                // Circular slider...
                    .overlay(
                        
                        ZStack {
                            
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)
                            
                            Circle()
                                .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                            .padding(-15)
                    )
            })
                .padding(.bottom, 20)
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
                
                if currentPage == 1 {
                    
                    Text("onboarding_welcome".localized(userLanguage))
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    
                    Button(action: {
                        // changing views...
                        withAnimation(.easeInOut) {
                            
                            currentPage -= 1
                        }
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }
                }
                
                
                
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
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(detail)
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 120)
        }
        .foregroundColor(.white)
        .background(bgColor.ignoresSafeArea())
    }
}

struct InitialScreenView: View {
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    var bgColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                
                if currentPage == 1 {
                    
                    Text("onboarding_welcome".localized(userLanguage))
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    
                    Button(action: {
                        // changing views...
                        withAnimation(.easeInOut) {
                            
                            currentPage -= 1
                        }
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }
                }
                
                
                
                Spacer()
                
                Button(action: {
                    
                    showOnboarding = false
                }, label: {
                    Text("onboarding_skip".localized(userLanguage))
                        .fontWeight(.semibold)
                        .kerning(1.2)
                })
            }
            .foregroundColor(.white)
            .padding()
            
            Spacer(minLength: 0)
            
            Image("tourmeapplogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: .white, radius: 30)
                .shadow(color: .white, radius: 30)
                .shadow(color: .white, radius: 30)
                .padding(10)
            
            Text("settings_choose_language".localized(userLanguage))
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)
            
            Picker("settings_choose_language".localized(userLanguage), selection: $userLanguage) {
                Image("US", bundle: FlagKit.assetBundle).tag(Language.en)
                Image("ES", bundle: FlagKit.assetBundle).tag(Language.es)
                Image("BR", bundle: FlagKit.assetBundle).tag(Language.pt)
            }.pickerStyle(.segmented)
                .padding(.horizontal, 30)
            
            Spacer(minLength: 120)
        }
        .background(bgColor.ignoresSafeArea())
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
        VStack(spacing: 10) {
            
            HStack {
                
                if currentPage == 1 {
                    
                    Text("onboarding_welcome".localized(userLanguage))
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    
                    Button(action: {
                        // changing views...
                        withAnimation(.easeInOut) {
                            
                            currentPage -= 1
                        }
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    }
                }
                
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
            
            //Spacer(minLength: 0)
            
            LottieView(name: "profile3", loopMode: .loop)
                .frame(width: 200, height: 200)
            /*
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(10)
             */
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(detail)
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
            Group {
                TextField("onboarding_email".localized(userLanguage), text: $email)
                    .pretty()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("onboarding_phone".localized(userLanguage), text: $phone)
                    .pretty()
                    .keyboardType(.phonePad)
                    .autocapitalization(.none)
                TextField("onboarding_display_name".localized(userLanguage), text: $displayName)
                    .pretty()
                    .keyboardType(.default)
                    .autocapitalization(.words)
            }
            .padding(.horizontal, 10)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            
            Spacer(minLength: 120)
        }
        .foregroundColor(.white)
        .background(bgColor.ignoresSafeArea())
        //.offset(y: -keyboardResponder.currentHeight*0.9)
        .onAppear {
            email = userEmail
            phone = userPhone
            displayName = userDisplayName
        }
        .onDisappear {
            saveProfileData()
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

var totalPages = 5

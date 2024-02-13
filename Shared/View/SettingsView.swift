//
//  SettingsView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/9/21.
//

import SwiftUI
import CoreMedia
import FlagKit
import UIKit
import MessageUI

struct SettingsView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("useSubtitles") var useSubtitles: Bool = false
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    @State private var isShowingMailView = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    
    @AppStorage("email") var userEmail = ""
    @AppStorage("phone") var userPhone = ""
    @AppStorage("displayName") var userDisplayName = ""
    
    //@EnvironmentObject var sessionManager: SessionManager
    //@EnvironmentObject var userPreferencesStore: UserPreferencesStore
    
    @ObservedObject var tourViewModel = TourViewModel()
    
    @State var isShowingPurchaseMessage = false
    @State var isShowingPurchaseErrorMessage = false
    @State var isShowingSignOutConfirmation = false
    @State var isShowingNotImplemented = false
    @State var isShowingCannotSendEmail = false
    @State var isShowingDeleteMeConfirmation = false
    @Environment(\.colorScheme) var colorScheme
    @State var isShowLogout = false
    
    @State var displayNameValue = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    VStack(alignment: .leading) {
                        VStack {
                            Form {
                                Section {
                                } header: {
                                    VStack(alignment: .leading) {
                                        Text("More".localized(userLanguage))
                                            .foregroundColor(.primary)
                                            .font(.custom(.inriaSansBold, size: 22))
                                            .textCase(.none)
                                        HStack {
                                            Text("Welcome".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansRegular, size: 20))
                                                .textCase(.none)
                                            Text("\(displayNameValue),")
                                                .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                                .font(.custom(.inriaSansRegular, size: 20))
                                                .textCase(.none)
                                            Spacer()
                                        }.padding(.top, 4)
                                    }
                                }
                                Section {
    //                                HStack {
    //                                    Image("smartphone")
    //                                        .renderingMode(.template)
    //                                        .foregroundColor(colorScheme == .dark ? .white : .gray)
    //                                    Text("Show Onboarding Screens".localized(userLanguage))
    //                                        .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
    //                                        .font(.custom(.inriaSansBold, size: 14))
    //                                }
                                    Button {
                                        if let appStoreURL = URL(string: "https://apps.apple.com/in/app/tourmeapp-israel/id1592914579") {
                                            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                                        }
                                    } label: {
                                        HStack {
                                            Image("reviews")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Review App".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }

                                    NavigationLink {
                                        UserProfileScreenView(image: "en_gedi_israel", title: "onboarding_user_profile_title".localized(userLanguage), detail: "May we have some Information?", bgColor: Color("PrimaryColor2"), emailFromSignUp: "", displayNameFromSignUp: "", isFromSettings: true)
                                            .transition(.scale)
                                    } label: {
                                        HStack {
                                            Image("edit_FILL0_wght300_GRAD0_opsz24 1")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Edit Profile".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }
                                } header: {
                                    Text("settings_membership_details".localized(userLanguage))
                                        .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                        .font(.custom(.inriaSansBold, size: 12))
                                }
                                
                                Section {
                                    NavigationLink {
                                        OnboardingView(isFromSettings: true)
                                    } label: {
                                        HStack {
                                            Image("language")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Change Language".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }

                                    HStack {
                                        Image("subtitles_FILL0")
                                            .renderingMode(.template)
                                            .foregroundColor(colorScheme == .dark ? .white : .gray)
                                        Text("Subtitle".localized(userLanguage))
                                            .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                            .font(.custom(.inriaSansBold, size: 14))
                                        Spacer()
                                        Image("toggle_off")
                                        .frame(width: 24, height: 24)
                                    }
                                } header: {
                                    Text("PREFERENCES".localized(userLanguage))
                                        .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                        .font(.custom(.inriaSansBold, size: 12))
                                }
                                Section {
                                    Button {
                                        isShowingMailView.toggle()
                                    } label: {
                                        HStack {
                                            Image("call")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Contact Us".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }

                                    Button {
                                        isShowingMailView.toggle()
                                    } label: {
                                        HStack {
                                            Image("help")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Get Help".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }

                                    Button {
                                        isShowingMailView.toggle()
                                    } label: {
                                        HStack {
                                            Image("bug")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Report a Bug".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }

                                    Button {
                                        isShowingMailView.toggle()
                                    } label: {
                                        HStack {
                                            Image("history")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Request a Feature".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }

                                } header: {
                                    Text("Support".localized(userLanguage))
                                        .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                        .font(.custom(.inriaSansBold, size: 12))
                                }
                                Section {
                                    Button {
                                        isShowLogout = true
                                    } label: {
                                        HStack {
                                            Image("logout_FILL0_wght300_GRAD0_opsz24 (2) 1")
                                                .renderingMode(.template)
                                                .foregroundColor(colorScheme == .dark ? .white : .gray)
                                            Text("Sign Out".localized(userLanguage))
                                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                                .font(.custom(.inriaSansBold, size: 14))
                                        }
                                    }

                                }
                            }.background(.primary)
                        }.background(.primary)
                        
                    }.background(.primary)
                    if isShowLogout {
                        LogoutView(isCancel: $isShowLogout)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingMailView) {
            EmailView(isShowing: $isShowingMailView, result: $result)
        }
        .onAppear(perform: {
            displayNameValue = userDisplayName
        })
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

#Preview {
    SettingsView()
}

struct EmailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }

            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<EmailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setToRecipients(["support@burris.co"])
        viewController.setSubject("")
        viewController.setMessageBody("", isHTML: false)

        return viewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<EmailView>) {
        // Update the view controller if needed
    }
}

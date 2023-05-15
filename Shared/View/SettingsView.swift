//
//  SettingsView.swift
//  tourmeapp
//
//  Created by Jonathan Burris on 8/9/21.
//

import SwiftUI
import CoreMedia
import FlagKit

struct SettingsView: View {
    
    @Environment(\.requestReview) var requestReview
    
    @AppStorage("userLanguage") var userLanguage: Language = .en
    @AppStorage("useSubtitles") var useSubtitles: Bool = false
    @AppStorage("currentPage") var currentPage = 1
    @AppStorage("showOnboarding") var showOnboarding = true
    
    @AppStorage("email") var userEmail = ""
    @AppStorage("phone") var userPhone = ""
    @AppStorage("displayName") var userDisplayName = ""
    
    @EnvironmentObject var sessionManager: SessionManager
    @EnvironmentObject var userPreferencesStore: UserPreferencesStore
    
    @ObservedObject var tourViewModel: TourViewModel
    
    @State var isShowingPurchaseMessage = false
    @State var isShowingPurchaseErrorMessage = false
    @State var isShowingSignOutConfirmation = false
    @State var isShowingNotImplemented = false
    @State var isShowingCannotSendEmail = false
    @State var isShowingDeleteMeConfirmation = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("settings_title".localized(userLanguage))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .kerning(1.4)
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                
                Spacer()
            }
            
            Form(content: {
                
                Section(header: Text("settings_membership_details".localized(userLanguage))) {
                    Text("\("settings_welcome_prefix".localized(userLanguage)) \(userDisplayName)")
                    Text("Email: \(userEmail)")
                    Text("Phone: \(userPhone)")
                    
                }
                
                Section(header: Text("settings_preferences".localized(userLanguage))) {
                    Picker("settings_choose_language".localized(userLanguage), selection: $userLanguage) {
                        Image("US", bundle: FlagKit.assetBundle).tag(Language.en)
                        Image("ES", bundle: FlagKit.assetBundle).tag(Language.es)
                        Image("BR", bundle: FlagKit.assetBundle).tag(Language.pt)
                    }.pickerStyle(.segmented)
                    
                    Button(action: {
                        currentPage = 1
                        showOnboarding = true
                    }) {
                        Text("settings_show_onboarding_screens".localized(userLanguage))
                    }
                }
                
                Section(header: Text("settings_support".localized(userLanguage))) {
                    Button(action: {
                        if EmailHelper.shared.canSendEmail() {
                            EmailHelper.shared.sendEmail(subject: "Contact Us", body: "", to: "info@tourmeapp.net")
                        } else {
                            isShowingCannotSendEmail = true
                        }
                    }, label: {
                        Text("settings_contact_us".localized(userLanguage))
                    })
                    Button(action: {
                        if EmailHelper.shared.canSendEmail() {
                            EmailHelper.shared.sendEmail(subject: "TourMeApp Support", body: "", to: "info@tourmeapp.net")
                        } else {
                            isShowingCannotSendEmail = true
                        }
                    }, label: {
                        Text("settings_get_help".localized(userLanguage))
                    })
                    Button(action: {
                        requestReview()
                    }, label: {
                        Text("settings_review_app".localized(userLanguage))
                    })
                    Button(action: {
                        if EmailHelper.shared.canSendEmail() {
                            EmailHelper.shared.sendEmail(subject: "TourMeApp Bug Report", body: "", to: "info@tourmeapp.net")
                        } else {
                            isShowingCannotSendEmail = true
                        }
                    }, label: {
                        Text("settings_report_a_bug".localized(userLanguage))
                    })
                    Button(action: {
                        if EmailHelper.shared.canSendEmail() {
                            EmailHelper.shared.sendEmail(subject: "TourMeApp Feature Request", body: "", to: "info@tourmeapp.net")
                        } else {
                            isShowingCannotSendEmail = true
                        }
                    }, label: {
                        Text("settings_request_a_feature".localized(userLanguage))
                    })
                }
                
                Section {
                    Button(action: {
                        isShowingSignOutConfirmation = true
                    },
                           label: {
                        Text("settings_sign_out".localized(userLanguage))
                    })
                        .alert(isPresented: $isShowingSignOutConfirmation) {
                            Alert(
                                title: Text("Are you sure you want to do this?"),
                                message: Text("You will be forced to login again."),
                                primaryButton: .destructive(Text("settings_sign_out".localized(userLanguage))) {
                                    sessionManager.signOut()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    
                }
                
                Section(header: Text("settings_personal_data".localized(userLanguage))) {
                    Text("settings_right_to_forget".localized(userLanguage))
                    Button(action: {
                        isShowingDeleteMeConfirmation = true
                    },
                           label: {
                        Text("settings_delete_me".localized(userLanguage))
                    })
                        .alert(isPresented: $isShowingDeleteMeConfirmation) {
                            Alert(
                                title: Text("Are you sure you want to do this?"),
                                message: Text("TourMeApp will delete all of your information including your login credentials."),
                                primaryButton: .destructive(Text("settings_delete_me".localized(userLanguage))) {
                                    sessionManager.deleteUser()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                }
            })
            //.navigationBarTitleDisplayMode(.large)
            //.navigationTitle("settings_title".localized(userLanguage))
                .alert(isPresented: $isShowingCannotSendEmail) {
                    Alert(title: Text("Cannot Send Email"),
                          message: Text("Either this device does not support mail or no account is setup."),
                          dismissButton: .default(Text("OK")))
                }
                .onAppear() {
                    let email = sessionManager.userProfile.email
                    userPreferencesStore.loadPurchases(emailAddress: email)
                    
                }
        }
        
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}

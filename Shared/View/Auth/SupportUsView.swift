//
//  SupportUsView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 27/11/23.
//

import SwiftUI


struct SupportUsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @State var isTen = true
    @State var isTwenty = false
    @State var isFifty = false
    @State var isCustom = false
    @State var customAmount = ""
    
    @ObservedObject var payPalViewModel = PayPalViewModel()
    var body: some View {
        ZStack {
            if payPalViewModel.isSuccess {
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(colorScheme == .light ? "back (3)" : "back (4)")
                        })
                        Text("Support Us".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 20))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                        .frame(height: 150)
                    VStack {
                        Spacer()
                            .frame(height: 90)
                        Text("Donation Success")
                          .font(
                            .custom(.inriaSansBold, size: 24)
                          )
                          .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                        Text("Thankyou for supporting us.")
                          .font(
                            .custom(.inriaSansBold, size: 16)
                          )
                          .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                          .padding(.top, 1)
                        Spacer()
                            .frame(height: 40)
                    }
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .dark ? Color(red: 0.28, green: 0.28, blue: 0.28) : .white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
                    .overlay {
                        Circle()
                            .fill(Color(red: 0.02, green: 0.62, blue: 0.85))
                            .frame(width: 125, height: 125)
                            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 2)
                            .offset(y: -100)
                    }
                    .overlay {
                        Image("done")
                            .offset(y: -100)
                    }
                    .overlay {
                        HStack(spacing: 35) {
                            Image("Vector 23")
                            Image("Vector 24")
                                .padding(.bottom, 20)
                            Image("Vector 25")
                        }
                        .offset(y: -185)
                    }
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Back to Home".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.95, green: 0.42, blue: 0.11))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(colorScheme == .light ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.95, green: 0.42, blue: 0.11), lineWidth: 1)
                                
                            )
                    }
                    .padding(.top, 40)
                    Spacer()
                    Image("donation 1")
                        .padding(.bottom)
                }.padding(.horizontal)
            }else{
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(colorScheme == .light ? "back (3)" : "back (4)")
                        })
                        Text("Support Us".localized(userLanguage))
                            .font(.custom(.inriaSansRegular, size: 20))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    VStack(alignment: .center) {
                        
                        Image("tourmeapp_logo")
                            .padding(.top)
                        Text("Donate to TourmeApp".localized(userLanguage))
                          .font(
                            .custom(.inriaSansBold, size: 22)
                          )
                          .foregroundColor(colorScheme == .dark ? .white : Color(red: 0.28, green: 0.28, blue: 0.28))
                          .padding(.top)
                        
                        HStack(spacing: 12) {
                            Text("$10")
                                .font(
                                    .custom(.inriaSansBold, size: 14)
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                .background(
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(colorScheme == .dark ? Color(red: 0.28, green: 0.28, blue: 0.28) : .white)
                                        .cornerRadius(5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .inset(by: 0.5)
                                                .stroke(Color(red: isTen ? 0.02 : 0.85, green: isTen ? 0.62 : 0.85, blue: 0.85), style: isTen ? StrokeStyle(lineWidth: 1) : StrokeStyle(lineWidth: 1, dash: [2, 2]))
                                        )
                                )
                                .onTapGesture {
                                    self.isTen = true
                                    self.isTwenty = false
                                    self.isFifty = false
                                    self.isCustom = false
                                }
                            
                            Text("$20")
                                .font(
                                    .custom(.inriaSansBold, size: 14)
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                .background(
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(colorScheme == .dark ? Color(red: 0.28, green: 0.28, blue: 0.28) : .white)
                                        .cornerRadius(5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .inset(by: 0.5)
                                                .stroke(Color(red: isTwenty ? 0.02 : 0.85, green: isTwenty ? 0.62 : 0.85, blue: 0.85), style: isTwenty ? StrokeStyle(lineWidth: 1) : StrokeStyle(lineWidth: 1, dash: [2, 2]))
                                        )
                                )
                                .onTapGesture {
                                    self.isTen = false
                                    self.isTwenty = true
                                    self.isFifty = false
                                    self.isCustom = false
                                }
                        }
                        .padding(.top)
                        
                        HStack(spacing: 12) {
                            Text("$50")
                                .font(
                                    .custom(.inriaSansBold, size: 14)
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                .background(
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .background(colorScheme == .dark ? Color(red: 0.28, green: 0.28, blue: 0.28) : .white)
                                        .cornerRadius(5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .inset(by: 0.5)
                                                .stroke(Color(red: isFifty ? 0.02 : 0.85, green: isFifty ? 0.62 : 0.85, blue: 0.85), style: isFifty ? StrokeStyle(lineWidth: 1) : StrokeStyle(lineWidth: 1, dash: [2, 2]))
                                        )
                                )
                                .onTapGesture {
                                    self.isTen = false
                                    self.isTwenty = false
                                    self.isFifty = true
                                    self.isCustom = false
                                }
                            if isCustom {
                                TextField("$Enter Amount".localized(userLanguage), text: $customAmount)
                                    .keyboardType(.numberPad)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                    .background(
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .background(Color(red: 0.02, green: 0.62, blue: 0.85).opacity(0.05))
                                            .cornerRadius(5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .inset(by: 0.5)
                                                    .stroke(Color(red: 0.02, green: 0.62, blue: 0.85), style: StrokeStyle(lineWidth: 1))
                                            )
                                    )
                                    .multilineTextAlignment(.center)
                                    .onSubmit {
                                        self.isTen = false
                                        self.isTwenty = false
                                        self.isFifty = false
                                        self.isCustom = false
                                    }
                            }else{
                                Text("Custom".localized(userLanguage))
                                    .font(
                                        .custom(.inriaSansBold, size: 14)
                                    )
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 45)
                                    .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                    .background(
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .background(colorScheme == .dark ? Color(red: 0.28, green: 0.28, blue: 0.28) : .white)
                                            .cornerRadius(5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .inset(by: 0.5)
                                                    .stroke(Color(red: isCustom ? 0.02 : 0.85, green: isCustom ? 0.62 : 0.85, blue: 0.85), style: isCustom ? StrokeStyle(lineWidth: 1) : StrokeStyle(lineWidth: 1, dash: [2, 2]))
                                            )
                                    )
                                    .onTapGesture {
                                        self.isTen = false
                                        self.isTwenty = false
                                        self.isFifty = false
                                        self.isCustom = true
                                    }
                            }
                        }
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            if isTen {
                                payPalViewModel.initiatePayment(amount: 10.00)
                            }else if isTwenty {
                                payPalViewModel.initiatePayment(amount: 20.00)
                            }else if isFifty {
                                payPalViewModel.initiatePayment(amount: 50.00)
                            }else if isCustom {
                                payPalViewModel.initiatePayment(amount: Double(customAmount) ?? 0.0)
                            }
                        }, label: {
                            Text("Donate with Paypal".localized(userLanguage))
                                .font(.custom(.inriaSansRegular, size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: (.infinity))
                                .frame(height: 50)
                                .background(Color.buttonThemeColor)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .padding(.top)
                        })
                        .padding(.bottom, 20)
                        Spacer()
                        Image("donation 1")
                            .padding(.bottom)
                    }.padding(.horizontal)
                }
            }
            if payPalViewModel.isLoading {
                ShowProgressView()
            }
        }
    }
    
}

#Preview {
    SupportUsView()
}


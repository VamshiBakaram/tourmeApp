//
//  SpecialEventsView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 29/12/23.
//

import SwiftUI
import ToastSwiftUI
import Kingfisher

struct SpecialEventsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("userLanguage") var userLanguage: Language = .en
    
    @ObservedObject var specialEventsViewModel = SpecialEventsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if specialEventsViewModel.isShowIndicator {
                    ShowProgressView()
                }else{
                    VStack(alignment: .leading) {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(colorScheme == .light ? "back (3)" : "back (4)")
                            })
                            Text("Special Events".localized(userLanguage))
                                .font(.custom(.inriaSansRegular, size: 20))
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding()
//                        Text("Special Events".localized(userLanguage))
//                            .font(.custom(.inriaSansBold, size: 22))
//                            .fontWeight(.bold)
//                            .foregroundColor(.primary)
//                            .padding(.horizontal)
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                                ForEach(specialEventsViewModel.specialEvents) { event in
                                    NavigationLink {
                                        SpecialEventsDetailsView(specialEvent: event)
                                            .navigationBarHidden(true)
                                    } label: {
                                        VStack(alignment: .leading) {
                                            KFImage.url(URL(string: event.eventThumbnailImageURL ?? ""))
                                                .resizable()
                                                .frame(height: 143)
                                                .clipped()
                                                .overlay(alignment: .topTrailing) {
                                                    Text((event.eventType ?? "" == "FREE") ? "FREE" : "$\(event.eventType ?? "")")
                                                        .font(.custom(.inriaSansBold, size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                                        .padding(.vertical, 4)
                                                        .padding(.horizontal, 8)
                                                        .background(Color.white)
                                                        .cornerRadius(5)
                                                        .padding(.all)
                                                }
                                            HStack {
                                                HStack {
                                                    Image(colorScheme == .light ? "Special event icon-2" : "Special event icon_white")
                                                    Text(self.getConvertedDate(format: "dd MMM yy", date: event.eventDateandTime ?? ""))
                                                        .font(.custom(.inriaSansBold, size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.white)
                                                }
                                                Spacer()
                                                HStack {
                                                    Image(colorScheme == .light ? "schedule_FILL" : "schedule_white")
                                                    Text(self.getConvertedDate(format: "hh:mm a", date: event.eventDateandTime ?? ""))
                                                        .font(.custom(.inriaSansBold, size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.white)
                                                }
                                            }
                                            .padding(.horizontal)
                                            .padding(.top, 3)
                                            Text(event.eventName ?? "")
                                                .font(.custom(.inriaSansBold, size: 18))
                                                .fontWeight(.bold)
                                                .foregroundColor(.primary)
                                                .padding(.horizontal)
                                                .padding(.top, 1)
                                            Divider()
                                                .background(colorScheme == .dark ? Color(red: 0.46, green: 0.46, blue: 0.46) : Color(red: 0.91, green: 0.91, blue: 0.91))
                                                .padding(.horizontal)
                                            HStack {
                                                if event.eventType ?? "" != "FREE" {
                                                    Text("Enroll ->".localized(userLanguage))
                                                        .font(.custom(.inriaSansBold, size: 16))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color(red: 0.95, green: 0.42, blue: 0.11))
                                                }
                                                Spacer()
                                                Text("View Event".localized(userLanguage))
                                                    .font(.custom(.inriaSansBold, size: 16))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.white)
                                            }
                                            .padding(.vertical, 4)
                                            .padding(.bottom, 8)
                                            .padding(.horizontal)
                                        }
                                        .background(colorScheme == .light ? Color.white : Color(red: 0.28, green: 0.28, blue: 0.28))
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 2)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .toast($specialEventsViewModel.errorMessage)
        }
    }
    
    
    
}

#Preview {
    SpecialEventsView()
}

extension View {
    func getConvertedDate(format: String, date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: date) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            let formattedString = outputFormatter.string(from: date)
            return formattedString
        } else {
            return "Invalid Date"
        }
    }
}

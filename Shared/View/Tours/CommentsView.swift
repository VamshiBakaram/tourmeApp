//
//  CommentsView.swift
//  tourmeapp (iOS)
//
//  Created by ahex on 08/01/24.
//

import SwiftUI
import ToastSwiftUI

struct CommentsView: View {
    
    @StateObject var commentsViewModel = CommentsViewModel()
    @EnvironmentObject var sessionManager: SessionManager
    @State var enteredComment = ""
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var commentCount: Int
    
    let id: Int
    let tourId: Int
    
    @State var commentText = ""
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(sessionManager.displayName.first?.uppercased() ?? "")
                        .foregroundStyle(Color.white)
                        .font(.custom(.inriaSansBold, size: 22))
                        .frame(width: 40, height: 40)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.02, green: 0.62, blue: 0.85), location: 0.00),
                                    Gradient.Stop(color: .black, location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                        .clipShape(Circle())
                        .padding(.leading, 16)
                    TextField("Write your coment...", text: $enteredComment)
                        .padding(.all, 13)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.80, green: 0.80, blue: 0.80), lineWidth: 1)
                            
                        )
                        .padding(.leading, 4)
                        .padding(.trailing, 2)
                        .background(colorScheme == .light ? Color.white : Color(red: 0.28, green: 0.28, blue: 0.28))
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMM yy - hh:mm a"
                        dateFormatter.locale = Locale.init(identifier: "en_us")
                        dateFormatter.timeZone = TimeZone.current
                        let date = dateFormatter.string(from: Date())
                        commentsViewModel.postComment(comment: enteredComment, tourId: tourId, id: self.id, userId: sessionManager.userId ?? "", date: date)
                    } label: {
                        Text("Send")
                            .frame(width: 80)
                            .frame(height: 45)
                            .font(.custom(.inriaSansRegular, size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(Color(red: 0.95, green: 0.42, blue: 0.11))
                            .cornerRadius(5)
                            .padding(.trailing)
                    }

                }
                .padding(.top, 30)
                Divider()
                    .padding(.vertical, 14)
                ScrollView{
                    LazyVStack(content: {
                        ForEach(0..<(commentsViewModel.comments?.data?.usersCommentdata?.count ?? 0), id: \.self) { index in
                            HStack(alignment: .top, spacing: 12) {
                                Text((commentsViewModel.comments?.data?.usersCommentdata?[index].userName ?? "").first?.uppercased() ?? "")
                                    .foregroundStyle(Color.white)
                                    .font(.custom(.inriaSansBold, size: 22))
                                    .frame(width: 40, height: 40)
                                    .background(
                                        LinearGradient(
                                            stops: [
                                                Gradient.Stop(color: Color(red: 0.02, green: 0.62, blue: 0.85), location: 0.00),
                                                Gradient.Stop(color: .black, location: 1.00),
                                            ],
                                            startPoint: UnitPoint(x: 0.5, y: 0),
                                            endPoint: UnitPoint(x: 0.5, y: 1)
                                        )
                                    )
                                    .clipShape(Circle())
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(commentsViewModel.comments?.data?.usersCommentdata?[index].userName ?? "")
                                          .font(.custom(.inriaSansBold, size: 14))
                                          .foregroundColor(Color(red: 0.02, green: 0.62, blue: 0.85))
                                        if let date = self.formatDate(commentsViewModel.comments?.data?.usersCommentdata?[index].datetime ?? "") {
                                            Text("|  \(date)")
                                              .font(
                                                .custom(.inriaSansRegular, size: 14)
                                              )
                                              .foregroundColor(Color(red: 0.59, green: 0.59, blue: 0.59))
                                        }
                                    }
                                    Text(commentsViewModel.comments?.data?.usersCommentdata?[index].comment ?? "")
                                      .font(
                                        .custom(.inriaSansBold, size: 14)
                                      )
                                      .foregroundColor(colorScheme == .light ? Color(red: 0.59, green: 0.59, blue: 0.59) : Color.black)
                                }
                                Spacer()
                            }
                        }
                    }).padding(.horizontal, 16)
                }
            }
            .toast($commentsViewModel.message)
            if commentsViewModel.isShowLoading {
                ShowProgressView()
            }
        }
        .onAppear {
            commentsViewModel.getcomments(id: self.id)
        }
        .onDisappear {
            commentCount = commentsViewModel.comments?.data?.usersCommentdata?.count ?? 0
        }
    }
    
    func formatDate(_ dateString: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"

            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "dd MMM yy - hh:mm a"
                return dateFormatter.string(from: date)
            }

            return nil
        }
}

//#Preview {
//    CommentsView(id: 2, tourId: 6, commentCount: <#Binding<Int>#>)
//}

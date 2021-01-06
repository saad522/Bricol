//
//  LeaveReviewViewController.swift
//  Bricol
//
//  Created by mac on 1/3/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct LeaveReviewViewController: View {
    
    @ObservedObject var user: User
    
    var name : String?
    var image : String?
    
    var dismiss: (() -> Void)?
    init(user : User,image : String, name : String) {
        self.image = image
        self.name = name
        self.user = user
            UITextView.appearance().backgroundColor = .clear
        
        }

    @State private var isAnimated : Bool = false
    @State private var rating: Int?
    @State private var profileText: String = "Tell us more about your expierence with Zakaria Lahrach"
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.2206355631, green: 0.2583793998, blue: 0.5023958683, alpha: 1))
                .ignoresSafeArea()
            VStack(alignment : .center) {
                HStack {
                    Button(action:dismiss!, label: {
                        Image(systemName: SFSymbols.dismissPost)
                            .font(.system(size: 35.0))
                            .foregroundColor(.white)
                            .padding(10)
                    })
                    Spacer()
                }
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                        WebImage(url: URL(string: user.pictureProfile ?? ""))
                            .resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay(Circle().stroke(Color.white,lineWidth: 2))
                            .aspectRatio(contentMode: .fill)
                            .rotationEffect(.degrees(isAnimated ? 0 : 360))
                            .position(x: isAnimated ?  15 : -250 , y: 100)
                            .frame(width: 125, height: 125)
                            .animation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.55))
                        WebImage(url: URL(string: image ?? ""))
                            .resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay(Circle().stroke(Color.white,lineWidth: 2))
                            .aspectRatio(contentMode: .fill)
                            .rotationEffect(.degrees(isAnimated ? 0 : 360))
                            .position(x:isAnimated ?  -10.0 : 250 , y: 100)
                            .frame(width: 125, height: 125)
                            .animation(.spring(response: 1, dampingFraction: 1, blendDuration: 0.55))
                            .onAppear {
                                self.isAnimated.toggle()
                            }
                    }
                    Text("\(user.name) & \(name ?? "")")
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .fontWeight(.black)
                        .padding(9)
                        .background(Color(#colorLiteral(red: 0.2747917771, green: 0.3171865344, blue: 0.5784322023, alpha: 1)))
                        .cornerRadius(10.0)
                        .scaleEffect(isAnimated ? 1 : 0)
                        .animation(.easeIn(duration: 1))
                }
                .padding(.top, -70)
                .padding(.vertical,5)
               
                    
                VStack {
                    Image("face-\(rating ?? 3)")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .animation(.spring(response: 0.55, dampingFraction: 0.55, blendDuration: 0))
                    
                    Spacer().frame(width: 0, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    RatingView(rating: $rating)
                    
                }
                .padding(.bottom, 15)
                VStack {
                    TextEditor(text: $profileText)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 25, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color(#colorLiteral(red: 0.185518533, green: 0.2229340971, blue: 0.4625527859, alpha: 1)))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                    
                    Spacer().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Button(action:{}, label: {
                        Text("Submit")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(Color(#colorLiteral(red: 0.185518533, green: 0.2229340971, blue: 0.4625527859, alpha: 1)))
                            .frame(width: UIScreen.main.bounds.width - 55, height: 59, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            .background(Color(#colorLiteral(red: 1, green: 0.9602848887, blue: 0.4598872662, alpha: 1)))
                            .cornerRadius(10)
                    })
                }
                Spacer().position(x: UIScreen.main.bounds.size.width / 2, y: 30)
            }
            Spacer()
            
        }.onTapGesture {
            self.hideKeyboard()
        }
       
    }
    
}
extension LeaveReviewViewController {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct RatingView: View {
    
    @Binding var rating: Int?
    var max: Int = 5
    var body: some View {
            HStack {
                ForEach(1..<(max + 1), id: \.self) { index in
                    Image(systemName: self.starType(index: index))
                        .resizable()
                        .frame(width: 45, height: 45)
                        .font(.system(size: 56.0, weight: .bold))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.9602848887, blue: 0.4598872662, alpha: 1)))
                        .onTapGesture {
                            self.rating = index
                        }
                }
            }
        }
    private func starType(index: Int) -> String {
            
            if let rating = self.rating {
                return index <= rating ? SFSymbols.starFill : SFSymbols.star
            } else {
                return SFSymbols.star
            }
            
        }
}
struct LeaveReviewViewController_Previews: PreviewProvider {
    static var previews: some View {
        LeaveReviewViewController(user: dummyUser, image: "", name: "")
    }
}

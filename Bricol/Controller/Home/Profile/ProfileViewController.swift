//
//  ProfileViewController.swift
//  Bricol
//
//  Created by mac on 1/2/21.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct ProfileViewController: View {
    @State var isPresented = false
    @State var isLogout    = false
    @State var name  = "Ali Saad Amine"
    @State var image = ""
    @State var phone = "0600430020"
    @State var city  = "Casablnca"
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            VStack(alignment : .leading) {
                VStack(alignment:  .center) {
                    Spacer().frame(width: 0, height: 25, alignment: .center)
                    HStack {
                        VStack(alignment : .leading) {
                            HStack {
                                
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.green)
                               
                                Text(name)
                                    .font(.title2)
                                    .fontWeight(.black)
                                    .foregroundColor(.titlesColor)
                            }
                            .padding(.vertical)
                            HStack {
                                Image(systemName: SFSymbols.location)
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.green)
                                Text("Maroc,\(city)")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            }
                            HStack {
                                Image(systemName: SFSymbols.phone)
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(.green)
                                Text(phone)
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            }
                        }
                        VStack {
//
                            WebImage(url: URL(string: image))
                                .resizable()
                                .frame(width: 85, height: 85, alignment: .center)
                                
                                .clipShape(Circle())
                                .overlay(Circle()
                                            .stroke(Color.green,lineWidth: 3.0))
                            Button(action:{
                                self.isPresented.toggle()
                            }, label: {
                                Text("Edit Profile")
                                    .foregroundColor(.white)
                                    .padding(7)
                                    .background(Color.green)
                                    .cornerRadius(5)
                            }).sheet(isPresented: $isPresented, content: {
                            EditProfileView(image: image)
                            })
                        }
                        
                    }
                    .padding().padding(.vertical,-1)
                    Spacer()
                        .frame(width: UIScreen.main.bounds.size.width, height: 0.5, alignment: .center)
                        .background(Color.green)
                    HStack(alignment : .center) {
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: "wrench.and.screwdriver.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .foregroundColor(.green)
                                Text("59")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            Text("Work")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }.padding()
                        Spacer()
                        Spacer()
                            .frame(width: 0.69, height: 55, alignment: .center)
                            .background(Color.green)
                        Spacer()
                        VStack {
                            HStack {
                                Image(systemName: SFSymbols.starFill)
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .foregroundColor(.green)
                                Text("59")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            Text("Rivews")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }.padding()
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.size.width, height: 66, alignment: .center)
                    .padding(.vertical,-5)
                    Spacer()
                        .frame(width: UIScreen.main.bounds.size.width, height: 0.9, alignment: .center)
                        .background(Color.green)
                        
                    
                }
                .background(Color.white).ignoresSafeArea(edges: .top)
                VStack(alignment : .leading) {
                    HStack {
                        Image(systemName: SFSymbols.setting)
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .center)
                            .foregroundColor(.titlesColor)
                        Text("Settings")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.titlesColor)
                    }
                    .padding(.leading,15)
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            VStack {
                                
                                Image(systemName: "doc.plaintext.fill")
                                    .resizable()
                                    .frame(width: 20, height: 25, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0, green: 0.7135828733, blue: 0.9728543162, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Invoice")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7135828733, blue: 0.9728543162, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).padding(3)
                        Button(action: {}, label: {
                            VStack {
                                
                                Image(systemName: "chart.bar.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0, green: 0.7530556321, blue: 0.3568419218, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Dashboard")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7530556321, blue: 0.3568419218, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).padding(3)
                        Button(action: {}, label: {
                            VStack {
                                
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .frame(width: 20, height: 25, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0.1805053353, green: 0.4249719381, blue: 0.9956683517, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Notification")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.1744393706, green: 0.4250463843, blue: 0.9956803918, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(3)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).padding(5)
                        Spacer()
                    }
                    .padding(.leading,-45)
                    .padding(.trailing,-45)
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            VStack {
                                
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 1, green: 0.7082486749, blue: 0, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Subscription")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.7082486749, blue: 0, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).padding(3)
                        Button(action: {}, label: {
                            VStack {
                                
                                Image(systemName: "hand.thumbsup.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0.5930123925, green: 0.6183419228, blue: 0.7479338646, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Rate us")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.5763781667, green: 0.6068079472, blue: 0.7319768071, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).padding(3)
                        Button(action: {
                               let firebaseAuth = Auth.auth()
                               do {
                                   try firebaseAuth.signOut()
                                if Auth.auth().currentUser?.uid == nil {
                                    isLogout.toggle()
                                }
                                    
                                } catch let signOutError as NSError {
                                   print ("Error signing out: %@", signOutError)
                               }
                        }, label: {
                            VStack {
                                
                                Image(systemName: "power")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 1, green: 0.2902308702, blue: 0.2394391298, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Log-out")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.9982815385, green: 0.2885649502, blue: 0.2402693927, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(3)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).fullScreenCover(isPresented: $isLogout, content: {
                            RegisterView()
                                .edgesIgnoringSafeArea(.all)
                            })
                        .padding(5)
                        Spacer()
                    }
                    .padding(.leading,-45)
                    .padding(.trailing,-45)
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            VStack {
                                
                                Image(systemName: "hand.point.up.braille.fill")
                                    .resizable()
                                    .frame(width: 25, height: 30, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0.1695019901, green: 0.6566048265, blue: 1, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Share")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.1695019901, green: 0.6566048265, blue: 1, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).padding(3)
                        Button(action: {}, label: {
                            VStack {
                                
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .padding(5)
                                    .background(Color(#colorLiteral(red: 0, green: 0.7187286019, blue: 0.7162085772, alpha: 1)))
                                    .cornerRadius(5.0)
                                Text("Get help")
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7187286019, blue: 0.7162085772, alpha: 1)))
                                
                            }.frame(width: 100, height: 85, alignment: .center)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10.0)
                        }).padding(3)
                        Spacer().frame(width: 100, height: 85, alignment: .center).padding(5)
                        Spacer()
                    }
                    .padding(.leading,-45)
                    .padding(.trailing,-45)
                }.padding(.vertical,-25)
            }
            
        }.onAppear {
            fetchUserData()
        }
        
    }
    func fetchUserData() {
        ServiceDatabase.shared.fetchUserInfo { (user, error) in
            if let error = error {
                print("Problem To Fetch User Data reason : ",error.localizedDescription)
                return
            }
            phone = user?.phone ?? ""
            image = user?.pictureProfile ?? ""
            name  = user?.name ?? ""
            city  = user?.city ?? ""
        }
    }
}
let dummyData : [String : Any] = [:]
let dummyUser : User = User(dectionary: dummyData)

struct ProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewController()
    }
}

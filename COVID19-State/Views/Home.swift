//
//  Home.swift
//  COVID19-State
//
//  Created by Tony Young on 2020/7/25.
//  Copyright © 2020 YangHan-Morningstar. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @State var index = 0
    
    var body: some View {
        VStack {
            VStack(spacing: 18) {
                HStack {
                    Text("Statistics")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("USA")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
                
                HStack {
                    Button(action: { self.index = 0 }) {
                        Text("My Country")
                            .foregroundColor(self.index == 0 ? .black : .white)
                            .padding(.vertical, 12)
                            .frame(width: (UIScreen.main.bounds.size.width / 2) - 30)
                    }
                    .background(self.index == 0 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                    
                    Button(action: { self.index = 1 }) {
                        Text("Global")
                            .foregroundColor(self.index == 1 ? .black : .white)
                            .padding(.vertical, 12)
                            .frame(width: (UIScreen.main.bounds.size.width / 2) - 30)
                    }
                    .background(self.index == 1 ? Color.white : Color.clear)
                    .clipShape(Capsule())
                }
                    .background(Color.black.opacity(0.25))
                    .clipShape(Capsule())
                    .padding(.top, 10)
                
                HStack(spacing: 15) {
                    VStack(spacing: 12) {
                        Text("Affected")
                            .fontWeight(.bold)
                        
                        Text("221,333")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.size.width / 2) - 30)
                    .background(Color("affected"))
                    .cornerRadius(12)
                    
                    VStack(spacing: 12) {
                        Text("Deaths")
                            .fontWeight(.bold)
                        
                        Text("221,333")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.size.width / 2) - 30)
                    .background(Color("death"))
                    .cornerRadius(12)
                }
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                HStack(spacing: 15) {
                    VStack(spacing: 12) {
                        Text("Recovered")
                        
                        Text("21,333")
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.size.width / 3) - 30)
                    .background(Color("recovered"))
                    .cornerRadius(12)
                    
                    VStack(spacing: 12) {
                        Text("Active")
                        
                        Text("21,333")
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.size.width / 3) - 30)
                    .background(Color("active"))
                    .cornerRadius(12)
                    
                    VStack(spacing: 12) {
                        Text("Serious")
                        
                        Text("21,333")
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.size.width / 3) - 30)
                    .background(Color("serious"))
                    .cornerRadius(12)
                }
                .foregroundColor(.white)
                .padding(.top, 10)

            }
            .padding(.horizontal)
            .padding(.bottom, 60)
            .background(Color("bg"))
            
            VStack(spacing: 15) {
                HStack {
                    Text("Last 7 Days")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.top)
                
                HStack {
                    ForEach(0...6, id: \.self) {_ in
                        VStack(spacing: 10) {
                            Text("330K")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            GeometryReader { geo in
                                VStack {
                                    Spacer(minLength: 0)
                                    
                                    Rectangle()
                                        .fill(Color("death"))
                                        .frame(width: 15)
                                }
                            }
                            
                            Text("4/4/20")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.bottom, -30)
            .offset(y: -40)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

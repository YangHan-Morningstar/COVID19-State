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
    @State var country = "China"
    @State var noCountry = false
    
    @ObservedObject var dataViewModel = DataViewModel()
    
    var body: some View {
        VStack {
            if dataViewModel.mainData != nil && !dataViewModel.daily.isEmpty{
                VStack {
                    VStack(spacing: 18) {
                        HStack {
                            Text("Statistics")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                self.makeCustomAlert()
                            }) {
                                Text(country)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
                        
                        HStack {
                            Button(action: {
                                self.index = 0
                                self.dataViewModel.mainData = nil
                                self.dataViewModel.daily.removeAll()
                                self.dataViewModel.getCountryData(country: self.country)
                            }) {
                                Text("My Country")
                                    .foregroundColor(self.index == 0 ? .black : .white)
                                    .padding(.vertical, 12)
                                    .frame(width: (UIScreen.main.bounds.size.width / 2) - 30)
                            }
                            .background(self.index == 0 ? Color.white : Color.clear)
                            .clipShape(Capsule())
                            
                            Button(action: {
                                self.index = 1
                                self.dataViewModel.mainData = nil
                                self.dataViewModel.daily.removeAll()
                                self.dataViewModel.getGlobalData()
                            }) {
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
                                
                                Text("\(self.dataViewModel.mainData.cases)")
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
                                
                                Text("\(self.dataViewModel.mainData.deaths)")
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
                                
                                Text("\(self.dataViewModel.mainData.recovered)")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.size.width / 3) - 30)
                            .background(Color("recovered"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12) {
                                Text("Active")
                                
                                Text("\(self.dataViewModel.mainData.active)")
                                    .fontWeight(.bold)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.size.width / 3) - 30)
                            .background(Color("active"))
                            .cornerRadius(12)
                            
                            VStack(spacing: 12) {
                                Text("Serious")
                                
                                Text("\(self.dataViewModel.mainData.critical)")
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
                            ForEach(self.dataViewModel.daily) {eachDaily in
                                VStack(spacing: 10) {
                                    Text("\(eachDaily.cases / 1000)k")
                                        .lineLimit(1)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    GeometryReader { geo in
                                        VStack {
                                            Spacer(minLength: 0)
                                            
                                            Rectangle()
                                                .fill(Color("death"))
                                                .frame(width: 15, height: self.dataViewModel.getCapsuleHeight(value: eachDaily.cases, height: geo.frame(in: .global).height))
                                        }
                                    }
                                    
                                    Text(eachDaily.day)
                                        .lineLimit(1)
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
            } else {
                Indicator()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            self.dataViewModel.getCountryData(country: self.country)
        }
        .alert(isPresented: $noCountry) {
            return Alert(title: Text("Error"), message: Text("Invalid City Name"), dismissButton: .destructive(Text("OK")))
        }
    }
    
    func makeCustomAlert() {
        let alert = UIAlertController(title: "Country", message: "Input a country", preferredStyle: .alert)
        
        alert.addTextField { (_) in
            
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            for country in countryList {
                if country.lowercased() == alert.textFields![0].text!.lowercased() {
                    self.country = alert.textFields![0].text!
                    self.dataViewModel.mainData = nil
                    self.dataViewModel.daily.removeAll()
                    self.dataViewModel.getCountryData(country: self.country)
                    return
                }
            }
            
            self.noCountry.toggle()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

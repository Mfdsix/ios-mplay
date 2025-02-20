//
//  ProfileView.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: "https://dicoding-web-img.sgp1.cdn.digitaloceanspaces.com/small/avatar/dos:8b98b613297963f528baa60c023deb3020211008131122.png")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 100)
                                .background(Color.gray.opacity(0.3))
                            
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())

                        case .failure:
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    
                    
                    Text("Mahfudz Ainur Rif'an")
                        .font(.title)
                        .bold()
                    
                    Text("iOS Developer")
                        .font(.caption)
                        .bold()
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ProfileView()
}

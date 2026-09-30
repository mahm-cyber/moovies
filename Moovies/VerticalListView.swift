//
//  VerticalListView.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 30/09/2026.
//

import SwiftUI

struct VerticalListView: View {
    var titles: [Title]
    
    
    var body: some View {
        
        GeometryReader { geo in
            List(titles) { title in
                NavigationLink {
                    TitleDetailView(title: title)
                } label: {
                    AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                        HStack {
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                                .padding(5)
                            
                            Text(title.name ?? title.title ?? "")
                                .font(.system(size: 14))
                                .bold()
                        }
                             
                    } placeholder: {
                        ProgressView()
                            .frame(width: geo.size.width)
                    }
                    .frame(height: 150)
                  
                }
               
            }
        }
        
    }
}

#Preview {
    VerticalListView(titles: Title.previewTitles)
}

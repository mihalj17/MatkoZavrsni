//
//  DetailsView.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 02.05.2024..
//

import SwiftUI

struct DetailsView: View {
    
    @Binding var mapSelection: Sight?
    @Binding var show: Bool
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(mapSelection?.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    
                }
                Spacer()
                
                Button{
                    show.toggle()
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            
        }

    }
}

#Preview {
    DetailsView(mapSelection: .constant(nil), show: .constant(false))
}

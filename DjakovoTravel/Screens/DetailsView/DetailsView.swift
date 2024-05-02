//
//  DetailsView.swift
//  DjakovoTravel
//
//  Created by Matko Mihalj on 02.05.2024..
//

import SwiftUI
import MapKit

struct DetailsView: View {
    
    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @State private var  lookAroundScene: MKLookAroundScene?
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(mapSelection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .padding(.trailing)
                    
                    
                }
                Spacer()
                
                Button{
                    show.toggle()
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 35,height: 35)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
                
            }
        }
        HStack(spacing: 24){
            Button{
                if let mapSelection{
                    mapSelection.openInMaps()
                }
            } label: {
                Text("Open in Maps")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 170, height: 48)
                    .background(.green)
                    .cornerRadius(12)
            }
            Button{
                show = false
            } label: {
                Text("Get Directions")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 170, height: 48)
                    .background(.blue)
                    .cornerRadius(12)
                    
            }
            
        }
        .onAppear{
            print("Debug: Did call on appear")
            fetchLookAroundPreview()
        }
        .onChange(of: mapSelection){ oldValue, newValue in
            print("Debug: Did call on change")
            fetchLookAroundPreview()
        }
        .padding()
    }
}

extension DetailsView{
    func fetchLookAroundPreview(){
        if let mapSelection{
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
}


#Preview {
    DetailsView(mapSelection: .constant(nil), show: .constant(false))
}

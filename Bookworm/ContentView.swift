//
//  ContentView.swift
//  Bookworm
//
//  Created by Bukhari Sani on 16/05/2023.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

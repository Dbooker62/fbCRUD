//
//  ContentView.swift
//  fbCRUD
//
//  Created by student on 4/12/24.
//

import SwiftUI
import CoreData

import SwiftUI

struct ContentView: View {
    var body: some View {
        EmployeeListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

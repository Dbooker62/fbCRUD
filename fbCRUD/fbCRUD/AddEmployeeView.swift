//
//  AddEmployeeView.swift
//  fbCRUD
//
//  Created by student on 4/12/24.
//

import Foundation
import SwiftUI
import Firebase

struct AddEmployeeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var designation: String = ""
    @State private var email: String = ""

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Enter name", text: $name)
            }
            Section(header: Text("Designation")) {
                TextField("Enter designation", text: $designation)
            }
            Section(header: Text("Email")) {
                TextField("Enter email", text: $email)
            }
            Section {
                Button("Save") {
                    addEmployee()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }
        }
        .navigationBarTitle("Add Employee")
    }
    
    private func addEmployee() {
        let db = Firestore.firestore()
        db.collection("employees").addDocument(data: [
            "name": name,
            "designation": designation,
            "email": email
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

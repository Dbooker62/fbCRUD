//
//  EmployeeDetailView.swift
//  fbCRUD
//
//  Created by student on 4/12/24.
//

import Foundation
import SwiftUI
import Firebase

struct EmployeeDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var employee: Employee
    @State private var name: String = ""
    @State private var designation: String = ""
    @State private var email: String = ""

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $name)
            }
            Section(header: Text("Designation")) {
                TextField("Designation", text: $designation)
            }
            Section(header: Text("Email")) {
                TextField("Email", text: $email)
            }
            Section {
                Button("Update") {
                    updateEmployee()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                Button("Delete") {
                    deleteEmployee()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
            }
        }
        .onAppear {
            name = employee.name
            designation = employee.designation
            email = employee.email
        }
        .navigationBarTitle("Edit Employee")
    }
    
    private func updateEmployee() {
        let db = Firestore.firestore()
        db.collection("employees").document(employee.id).updateData([
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

    private func deleteEmployee() {
        let db = Firestore.firestore()
        db.collection("employees").document(employee.id).delete() { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

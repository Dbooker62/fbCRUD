//
//  EmployeeListView.swift
//  fbCRUD
//
//  Created by student on 4/12/24.
//

import Foundation
import SwiftUI
import Firebase

struct EmployeeListView: View {
    @State private var employees = [Employee]()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Name")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    Text("Designation")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.purple)

                List(employees) { employee in
                    NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                        HStack {
                            Text(employee.name)
                                .foregroundColor(.white)
                            Spacer()
                            Text(employee.designation)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .listRowBackground(Color.blue)
                }
            }
            .navigationBarTitle("Employees", displayMode: .inline)
            .background(Color.purple)
            .navigationBarItems(trailing: NavigationLink(destination: AddEmployeeView()) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .onAppear {
                fetchEmployees()
            }
        }
    }

    private func fetchEmployees() {
        let db = Firestore.firestore()
        db.collection("employees").getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshot = snapshot {
                    employees = snapshot.documents.map { doc -> Employee in
                        let data = doc.data()
                        return Employee(id: doc.documentID,
                                        name: data["name"] as? String ?? "",
                                        designation: data["designation"] as? String ?? "",
                                        email: data["email"] as? String ?? "")
                    }
                }
            }
        }
    }
}

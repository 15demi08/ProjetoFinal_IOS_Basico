//
//  ProjetoFinal_IOS_BasicoApp.swift
//  ProjetoFinal_IOS_Basico
//
//  Created by IOS SENAC on 04/09/21.
//

import SwiftUI

@main
struct ProjetoFinal_IOS_BasicoApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            ContentView().environment(\.managedObjectContext, Persistencia.db.container.viewContext)
        }
        
    }
}

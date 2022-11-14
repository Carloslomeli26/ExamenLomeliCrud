//
//  ContentView.swift
//  ExamenLomeliCrud
//
//  Created by CCDM29 on 14/11/22.
//

import SwiftUI
import CoreData
struct ContentView: View {
    @Enviroment (\.managedObjectContext) var context
    @FetchRequest (sortDescriptors: <#T##[NSSortDescriptor]#>, KeyPath: \Item.nombre, animation: <#T##Animation?#>)
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

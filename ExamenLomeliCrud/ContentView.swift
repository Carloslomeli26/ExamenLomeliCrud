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
    @FetchRequest(entity: Empleados.entity(), sortDescriptors:  []) var empleados: FetchedResults<Empleados>
    @State private var nuevoempleadonom = ""

    
    var body: some View {
        VStack      {
            TextField("ADD NEW", text: self.$nuevoempleadonom).multilineTextAlignment(.center)
            Button("Save"){self.guardar()}
            List{
                ForEach(empleados, id:\.self){ empleado in
                    Text("\(empleado.name!)")

                }
                .onDelete{ indexSet in
                    for index in indexSet{
                        self.context.delete(self.empleados[index])
                        try? self.context.guardar()
                    }
                    //hola
                }
                
            }
        }
            
    }
    func guardar(){
        let nuevoempleado = Empleados(context: self.context)
        nuevoempleado.name = nuevoempleadonom
        try? self.context.guardar()
    }
}


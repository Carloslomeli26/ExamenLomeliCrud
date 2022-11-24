//
//  ContentView.swift
//  ExamenLomeliCrudd
//
//  Created by CCDM29 on 22/11/22.
//

import SwiftUI

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var id = ""
    @State var empNombre = ""
    @State var empApePat = ""
    @State var empApeMat = ""
    @State var domicilio = ""
    @State var telefono = ""

    @State var seleccionado: Empleados?
    @State var empArray = [Empleados]()


    var body: some View {
            VStack{

                    TextField("ID Empleado:", text: self.$id).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Nombre Empleado:", text: self.$empNombre).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Apellido Paterno", text: self.$empApePat).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Apellido Materno", text: self.$empApeMat).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Domicilio:", text: self.$domicilio).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Telefono:", text: self.$telefono).textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Guardar"){
                 if(seleccionado != nil){
                    seleccionado?.id = id
                    seleccionado?.empNombre = empNombre
                    seleccionado?.empApePat = empApePat
                    seleccionado?.empApeMat = empApeMat
                    seleccionado?.domicilio = domicilio
                    seleccionado?.telefono = telefono
                    coreDM.actualizarEmpleado(empleado:seleccionado!)
                    }else{
                    coreDM.guardarEmpleado(id: id, empNombre: empNombre, empApePat: empApePat, empApeMat: empApeMat, domicilio: domicilio, telefono: telefono)
                             }
                            mostrarEmpleado()
                            id = ""
                            empNombre = ""
                            empApePat = ""
                            empApeMat = ""
                            domicilio = ""
                            telefono = ""
                            seleccionado = nil
                            }
                List{
                    ForEach(empArray, id: \.self){
                        emp in
                        VStack{
                            Text(emp.id ?? "")
                            Text(emp.empNombre ?? "")
                            Text(emp.empApePat ?? "")
                            Text(emp.empApeMat ?? "")
                            Text(emp.domicilio ?? "")
                            Text(emp.telefono ?? "")
                        }
                        .onTapGesture{
                        seleccionado = emp
                        id = emp.id ?? ""
                        empNombre = emp.empNombre ?? ""
                        empApePat =  emp.empApePat ?? ""
                        empApeMat =  emp.empApeMat ?? ""
                        domicilio =  emp.domicilio ?? ""
                        telefono =  emp.telefono ?? ""
                    }
                        
                    }.onDelete(perform: {
                        indexSet in
                        indexSet.forEach({ index in
                        let empleado = empArray[index]
                            coreDM.borrarEmpleado(empleado: empleado)
                        mostrarEmpleado()
                        })
                    })
                }.padding()
                    .onAppear(perform: {mostrarEmpleado()})
            }
        
    }
    func mostrarEmpleado(){
            empArray = coreDM.leerTodosLosEmpleados()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}

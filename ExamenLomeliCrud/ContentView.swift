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
    
    @State var nid = ""
    @State var nempNombre = ""
    @State var nempApePat = ""
    @State var nempApeMat = ""
    @State var ndomicilio = ""
    @State var ntelefono = ""

    @State var seleccionado: Empleados?
    @State var empArray = [Empleados]()
    @State var isTapped = false


    var body: some View {
        NavigationView{
            VStack{
                Text("Gestión de Empleados")
                    .foregroundColor(.black)
                    .padding(2)
                    .font(.system(.title, design: .monospaced))
                   
                NavigationLink(destination: VStack{
                    Text("Agregar Empleados")
                        .foregroundColor(.black)
                        .padding(2)
                        .font(.system(.title, design: .monospaced))
                    TextField("ID Empleado:", text: self.$nid).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(2)
                    .font(.headline)
                    .background(Color.gray.opacity(0.3))
                    TextField("Nombre Empleado:", text: self.$nempNombre).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(2)
                    .font(.headline)
                    .background(Color.gray.opacity(0.3))
                    TextField("Apellido Paterno", text: self.$nempApePat).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(2)
                    .font(.headline)
                    .background(Color.gray.opacity(0.3))
                    TextField("Apellido Materno", text: self.$nempApeMat).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(2)
                    .font(.headline)
                    .background(Color.gray.opacity(0.3))
                    TextField("Domicilio:", text: self.$ndomicilio).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(2)
                    .font(.headline)
                    .background(Color.gray.opacity(0.3))
                    TextField("Telefono:", text: self.$ntelefono).textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(2)
                    .font(.headline)
                    .background(Color.gray.opacity(0.3))
                
                Button("Guardar"){
                    coreDM.guardarEmpleado(id: nid, empNombre: nempNombre, empApePat: nempApePat, empApeMat: nempApeMat, domicilio: ndomicilio, telefono: ntelefono)
                            id = ""
                            empNombre = ""
                            empApePat = ""
                            empApeMat = ""
                            domicilio = ""
                            telefono = ""
                            mostrarEmpleado()
                            }
                }){
                        Text("agregar")
                    
                    }
                .padding(24)
                .font(.system(.title, design: .monospaced))
                .frame(height: 30)
                .foregroundColor(.white)
                .background(Color.green.opacity(0.7))
                .cornerRadius(4)
            
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
                        isTapped.toggle()
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
            
                NavigationLink("",destination:VStack{
                    Text("Editar Empleados")
                        .foregroundColor(.black)
                        .padding(2)
                        .font(.system(.title, design: .monospaced))
                        TextField("ID Empleado:", text: self.$id).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(2)
                        .font(.headline)
                        .background(Color.gray.opacity(0.3))
                        TextField("Nombre Empleado:", text: self.$empNombre).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(2)
                        .font(.headline)
                        .background(Color.gray.opacity(0.3))
                        TextField("Apellido Paterno", text: self.$empApePat).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(2)
                        .font(.headline)
                        .background(Color.gray.opacity(0.3))
                        TextField("Apellido Materno", text: self.$empApeMat).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(2)
                        .font(.headline)
                        .background(Color.gray.opacity(0.3))
                        TextField("Domicilio:", text: self.$domicilio).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(2)
                        .font(.headline)
                        .background(Color.gray.opacity(0.3))
                        TextField("Telefono:", text: self.$telefono).textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(2)
                        .font(.headline)
                        .background(Color.gray.opacity(0.3))
                    Button("Editar"){
                        seleccionado?.id = id
                        seleccionado?.empNombre = empNombre
                        seleccionado?.empApePat =  empApePat
                        seleccionado?.empApeMat =  empApeMat
                        seleccionado?.domicilio =  domicilio
                        seleccionado?.telefono =  telefono
                        
                        coreDM.actualizarEmpleado(empleado: seleccionado!)
                        id = ""
                        empNombre = ""
                        empApePat = ""
                        empApeMat = ""
                        domicilio = ""
                        telefono = ""
                        mostrarEmpleado()
                                }
            
        }, isActive: $isTapped)
            
        }
          
    }
        
        .background(Color.green.opacity(0.7))
        .cornerRadius(4)
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

import SwiftUI

struct ContentView: View {
    let coreDM: Persistence
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


    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: VStack{
                    TextField("ID Empleado:", text: self.$nid).multilineTextAlignment(.center)
                    TextField("Nombre Empleado:", text: self.$nempNombre).multilineTextAlignment(.center)
                    TextField("Apellido Paterno", text: self.$nempApePat).multilineTextAlignment(.center)
                    TextField("Apellido Materno", text: self.$nempApeMat).multilineTextAlignment(.center)
                    TextField("Domicilio:", text: self.$ndomicilio).multilineTextAlignment(.center)
                    TextField("Telefono:", text: self.$ntelefono).multilineTextAlignment(.center)

                    Button("Guardar"){
                        coreDM.guardarEmpleado(id: nid, empNombre: nempNombre, empApePat: nempApePat, empApeMat: nempApeMat, domicilio: ndomicilio, telefono: ntelefono)
                        nid = ""
                        nempNombre = ""
                        nempApePat = ""
                        nempApeMat = ""
                        ndomicilio = ""
                        ntelefono = ""
                        mostrarEmpleado()
                    }
                    }){
                    Text("Agregar")
                }

                List{
                    ForEach(empArray, id: \.self){
                        emp in
                        VStack{
                            Text(emp.empNombre ?? "")
                        }
                        .onTapGesture{
                            seleccionado = emp
                            id = emp.id ?? ""
                        }
                    }.onDelete(perform: {
                        indexSet in
                        indexSet.forEach({ index in
                        let empleado = empArray[index]
                            coreDM.borrarEmpleado(empleado: <#T##Empleados#>)
                        mostrarEmpleado()
                        })
                    })
                }.padding()
                    .onAppear(perform: {mostrarEmpleado()})
            }
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


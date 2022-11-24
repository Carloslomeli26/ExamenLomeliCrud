import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer: NSPersistentContainer

    init(){
        persistentContainer = NSPersistentContainer(name: "Empleados")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion, error) in
            if let error = error {
                fatalError("Core data failed \(error.localizedDescription)")
            }
        })
    }

    func guardarEmpleado(id: String, empNombre: String, empApePat: String, empApeMat: String, domicilio: String,telefono: String){
        let empleados = Empleados(context: persistentContainer.viewContext)
        empleados.id = id
        empleados.empNombre = empNombre
        empleados.empApePat = empApePat
        empleados.empApeMat = empApeMat
        empleados.domicilio = domicilio
        empleados.telefono = telefono
        

        do{
            try persistentContainer.viewContext.save()
            print("empleado guardado")
        }
        catch{
            print("failed to save error")
        }
    }

    func leerTodosLosEmpleados() -> [Empleados]{
        let fetchRequest: NSFetchRequest<Empleados> = Empleados.fetchRequest()

        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return []
        }
    }

    func borrarEmpleado(empleado: Empleados){
        persistentContainer.viewContext.delete(empleado)

        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context")
        }
    }

    func actualizarEmpleado(empleado: Empleados){
        let fetchRequest: NSFetchRequest<Empleados> = Empleados.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", empleado.id ?? "")
        fetchRequest.predicate = predicate


        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.empNombre = empleado.empNombre
            p?.empApePat = empleado.empApePat
            p?.empApeMat = empleado.empApeMat
            p?.domicilio = empleado.domicilio
            p?.telefono = empleado.telefono
            try persistentContainer.viewContext.save()
            print("empleado guardado")
        }catch{
            print("failed to save error en \(error)")
        }
    }

    func leerEmpleado(idemp: String) -> Empleados?{
        let fetchRequest: NSFetchRequest<Empleados> = Empleados.fetchRequest()
        let predicate = NSPredicate(format: "idemp = %@", idemp)
        fetchRequest.predicate = predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }catch{
            print("failed to save error en \(error)")
        }
        return nil
    }
}

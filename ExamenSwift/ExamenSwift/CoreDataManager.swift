//
//  CoreDataManager.swift
//  ExamenSwift
//
//  Created by CCDM22 on 29/11/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Producto")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion, error) in
            if let error = error {
                fatalError("Core Data failed to init \(error.localizedDescription)")
            }
        })
    }
    
    func guardarProducto(id_producto: String, nombre_producto: String, marca_producto: String, descripcion_producto: String, precio_producto: String, existencia_producto: String)
    {
        let producto = Producto (context: persistentContainer.viewContext)
        producto.id_producto = id_producto
        producto.nombre_producto = nombre_producto
        producto.marca_producto = marca_producto
        producto.descripcion_producto = descripcion_producto
        producto.precio_producto = precio_producto
        producto.existencia_producto = existencia_producto
        
        do{
            try persistentContainer.viewContext.save()
            print("Producto guardado con exito!")
        }catch{
            print("Producto no guardado en \(error)")
        }
    }
        
        func leerTodosProductos() -> [Producto]{
            let fetchRequest : NSFetchRequest<Producto> = Producto.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }catch{
            return []
        }
    }
    
    func leerProducto(id_producto: String) -> Producto?{
        let fetchRequest:NSFetchRequest<Producto>=Producto.fetchRequest()
        let predicate = NSPredicate(format: "id_producto = %@", id_producto )
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }catch{
            print("Producto no guardado \(error)")
        }
        return nil
    }
    
    func actualizarProducto(producto: Producto){
        let fetchRequest:NSFetchRequest<Producto>=Producto.fetchRequest()
        let predicate = NSPredicate(format: "id_producto = %@", producto.id_producto ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.id_producto = producto.id_producto
            p?.nombre_producto = producto.nombre_producto
            p?.descripcion_producto = producto.descripcion_producto
            p?.marca_producto = producto.marca_producto
            p?.existencia_producto = producto.existencia_producto
            p?.precio_producto = producto.precio_producto
            try persistentContainer.viewContext.save()
            print("Producto guardado")
            
        }catch{
            print("Failed to save en \(error)")
        }
    }
    
    
    
    func borrarProducto(producto : Producto){
        persistentContainer.viewContext.delete(producto)
        
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Fallo al guardar \(error.localizedDescription)")
        }
    }
    


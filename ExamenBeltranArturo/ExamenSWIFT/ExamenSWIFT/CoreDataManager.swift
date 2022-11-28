//
//  CoreDataManager.swift
//  ExamenSWIFT
//
//  Created by CCDM08 on 24/11/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContaine = NSPersistentContainer("Producto")
        persistentContainer.loadPersistentStores(completionHandler:{
            (descripcion, error) in
            if let error = error {
                fatalError("Core Data failed to init \(error.localizedDescription)")
            }
        })
    }
    
    func guardarProducto(id_producto: Int32, nombre_producto: String, marca_producto: String, descripcion_producto: String, precio_producto: Decimal, existencia_producto: Int)
    {
        let producto = Producto (context: persistentContainer.viewContext)
        producto.id_producto = id_producto
        producto.nombre_producto = nombre_producto
        producto.marca_producto = marca_producto
        producto.descripcion_producto = descripcion_producto
        
    }
    
}

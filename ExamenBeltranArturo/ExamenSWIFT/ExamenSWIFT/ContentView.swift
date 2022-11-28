//
//  ContentView.swift
//  ExamenSWIFT
//
//  Created by CCDM08 on 24/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var id_producto = ""
    @State var nombre_producto = ""
    @State var marca_producto = ""
    @State var descripcion_producto = ""
    @State var precio_producto = ""
    @State var existencia_producto = ""
    @State var producto_array = [Producto]()

    var body: some View {
        VStack {
            TextField("ID Producto: ", text: $id_producto)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Nombre producto: ", text: $nombre_producto)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Descripcion del producto: ", text: $descripcion_producto)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Precio del producto: ", text: $precio_producto)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Existencia del producto: ", text: $existencia_producto)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Guardar"){
                coreDM.guardarProducto(id_producto: id_producto, nombre_producto: nombre_producto, marca_producto: marca_producto, descripcion_producto: descripcion_producto, precio_producto: precio_producto, existencia_producto: existencia_producto)
                mostrarProducto()
                id_producto = ""
                nombre_producto = ""
                marca_producto = ""
                descripcion_producto = ""
                precio_producto = ""
                existencia_producto = ""
            }
            List{
                ForEach(producto_array, id: \.self){
                    prod in
                    VStack{
                        Text(prod.id_codigo ?? "")
                        Text(prod.nombre_producto ?? "")
                        Text(prod.marca_producto ?? "")
                        Text(prod.descripcion_producto ?? "")
                        Text(prod.precio_producto ?? "")
                        Text(prod.existencia_producto ?? "")
                    }
                }.onDelete(perform: {
                    indexSet in
                    indexSet.ForEach({ index in
                        let producto = producto_array[index]
                        coreDM.borrarProducto(producto: producto)
                        mostrarProducto()
                    })
                })
                
            }.padding().onAppear(perform: {mostrarProducto()})
    }
    
    func mostrarProducto(){
        producto_array = coreDM.leerProductos()
    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM:CoreDataManager())
    }
}
    }
}

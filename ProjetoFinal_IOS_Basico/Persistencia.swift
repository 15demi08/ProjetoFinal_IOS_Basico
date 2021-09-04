//
//  Persistencia.swift
//  Aula05_AppLoja
//
//  Created by IOS SENAC on 04/09/21.
//

import CoreData

struct Persistencia {
    
    // Singleton
    static let db = Persistencia()
    
    let container:NSPersistentContainer
    
    init(){
        
        // Container para o modelo de dados
        container = NSPersistentContainer(name: "modeloDados")
        container.loadPersistentStores{ (decricao, erro) in
            if let erro = erro {
                fatalError("Erro: \(erro.localizedDescription)")
            }
        }
        
    }
    
    func salvar( callback: @escaping (Error?) -> () = {_ in} ){
        
        let contexto = container.viewContext
        
        if contexto.hasChanges {
            
            do {
                try contexto.save()
                callback(nil)
            } catch {
                callback(error)
            }
            
        }
            
    }
    
    func deletar( _ objeto:NSManagedObject, callback: @escaping (Error?) -> () = {_ in} ){
        
        let contexto = container.viewContext
        
        contexto.delete(objeto)
        
        salvar(callback: callback)
        
    }
    
}

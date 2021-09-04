//
//  ContentView.swift
//  ProjetoFinal_IOS_Basico
//
//  Created by IOS SENAC on 04/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var contexto
    
    @FetchRequest(
        entity: Jogo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Jogo.nome, ascending: true)]
    ) var jogos:FetchedResults<Jogo>
    
         var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack() {
                    
                    NavigationLink("Novo Jogo", destination: TelaCadastroJogo())
                    Text("-")
                    NavigationLink("Novo Gênero", destination: TelaCadastroGenero())
                    
                }
                
                List {
                    
                    Section(header: Text("Jogos na Biblioteca")){
                        
//                        if( !jogos.isEmpty ){
//
//                            ForEach(jogos, id: \.self){ jogo in
//
//                                NavigationLink(jogo.nome!, destination: DetalhesJogo(jogoAtual:jogo)).padding()
//
//                            }
//
//                        }
                        
                    }
                    
                }
                
            }.navigationBarTitle(Text("Biblioteca"))
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .topLeading)
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    
}

struct DetalhesJogo:View {
    
    var jogoAtual:Jogo
    
    var body: some View {
        
        VStack {
            
            
            
        }.navigationBarTitle(Text("Detalhes: \(jogoAtual.nome!)"), displayMode: .inline)
        
    }
    
}

struct TelaCadastroJogo:View {
    
    @Environment(\.managedObjectContext) var contexto
    
    @FetchRequest(
        entity: Genero.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Genero.nome, ascending: true)]
    ) var generos:FetchedResults<Genero>
    
    @State var txtNome = ""
    @State var txtDev = ""
    @State var generoSelecionado:Genero? = nil
    
//    init() {
//        generoSelecionado = generos.first
//    }
    
    var body: some View {
        
        VStack(spacing: 10.0) {
            
            TextField("Nome", text: $txtNome)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Desenvolvedora", text: $txtDev)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("Gênero", selection: $generoSelecionado){

                ForEach(generos, id: \.self){ genero in

                    Text(genero.nome!).tag(genero)

                }

            }

            Button("Salvar"){
                
                let novoJogo = Jogo(context: contexto)
                novoJogo.nome = txtNome
                novoJogo.desenvolvedora = txtDev
                novoJogo.toGenero = generoSelecionado
                
                Persistencia.db.salvar()
                
                txtNome = ""
                txtDev = ""
                generoSelecionado = nil
                
            }.padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(5.0)
            
        }.navigationBarTitle(Text("Novo Jogo"), displayMode: .inline)
        .padding(10.0)
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .topLeading)
        
    }
    
}

struct TelaCadastroGenero:View {
    
    @Environment(\.managedObjectContext) var contexto
    
    @FetchRequest(
        entity: Genero.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Genero.nome, ascending: true)]
    ) var generos:FetchedResults<Genero>
    
    @State var txtNovoGenero = ""
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                TextField("Nome", text: $txtNovoGenero)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Salvar"){
                    
                    let novoGenero = Genero(context: contexto)
                    novoGenero.nome = txtNovoGenero
                    
                    Persistencia.db.salvar()
                    
                    let jogo = Jogo(context: contexto)
                    jogo.nome = "Call of Duty"
                    jogo.desenvolvedora = "Ep"
                    jogo.toGenero = novoGenero
                    Persistencia.db.salvar()
                    txtNovoGenero = ""
                    
                }.padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(5.0)
                
            }.padding()
            
            List {
                
                ForEach ( generos, id: \.self ){ genero in
                    
                    Text(genero.nome!)
                    
                }
                
            }
            
        }.navigationBarTitle(Text("Novo Gênero"), displayMode: .inline)
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .topLeading)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

package edu.unam.integrador;

import io.javalin.*;
import io.javalin.http.Context;
import java.util.Collections;
import org.sql2o.Sql2o;
import edu.unam.integrador.controladores.ClientesControlador;
import edu.unam.integrador.paginas.*;
import edu.unam.integrador.repositorio.Sql2oClientesRepositorio;

public class App {
    public static void main( String[] args ){
        // Conexión de sql2o
        var sql2o = new Sql2o("jdbc:postgresql://localhost:5432/distribuidora", "postgres", "gpl");

        //Repositorio y Controladores
        
        var clientesRepositorio = new Sql2oClientesRepositorio(sql2o);
        var clientesControlador = new ClientesControlador(clientesRepositorio);
    

        // Crear Servidor    
        Javalin app = Javalin.create(config -> {
            config.addStaticFiles("/public");
        }).start(8000);

        //Defino rutas
       // app.get("/", App::mostrarIndex); // Muestra el inicio
       app.get("/clientes", clientesControla);
         
    /*
    
    */  
}

   
}

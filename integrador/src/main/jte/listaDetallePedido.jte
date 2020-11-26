@tag.headers()

<div class="card" style="width: 95%; top: 2rem; left: 45px; right: 25px; margin-bottom: 3rem;"> 
    <div class="card-footer">
        <div style="margin-left: 3em; ">
            <h2><b>Lista de Pedido</b></h2>
            <br>
            <form action="/pedidos/finalizar" method="post">
                <div style="margin-top: 6em; margin-left: 15em; margin-right: 15em;">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped">
                            <thead>
                                <tr>  
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                    <th>Neto</th>
                                </tr>
                            </thead>
                            <tbody>
                                    <tr>
                                        <td>Mandarina</td>
                                        <td>10</td>
                                        <td>100</td>
                                        <td>10.000</td>
                                        <td> <a type="button" class="btn btn-info no-gutters" href=""> Editar </a></td>
                                        <td> <button type="button" class="btn btn-danger no-gutters" onClick=""> Quitar </button></td>
                                    </tr>
                            
                            </tbody>
                        </table>
                    </div>
                    <button type="submit" class="btn btn-primary"> Finalizar </button>
                    <a href="/" style="float: right;" type="button" class="btn btn-primary"> Volver </a>
                </div>
            </form>
        </div>
    </div>
</div>

@tag.footer()
<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="TiposTrastornos.aspx.cs" Inherits="ICERP.Catalogos.TiposTrastornos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <script type="text/javascript">

        $(function () {
            $('#example2').DataTable({
                "language": {
                    "zeroRecords": "No hay registros",
                    "info": "Mostrando (_START_ a _END_) de un total de _TOTAL_ ",
                    "infoEmpty": "Mostrando (0 a 0) de un total de 0",
                    "lengthMenu": "Mostrar _MENU_ Filas",
                    "infoFiltered": "(Filtrados de  _MAX_ Registros)",
                    "search": "Buscar:",
                    "paginate": {
                        "previous": "Anterior",
                        "next": "Siguiente"
                    }
                },
                "responsive": true
            });
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        <div class="box box-danger">
        <div class="box-header with-border">
            <h3 class="box-title">Registro de Tipos de Trastornos</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
            <div class="col-sm-3">
                <div class="form-group">
                    <label for="nombre">Tipo de Trastorno</label>
                    <input type="text" class="form-control" id="nombre" placeholder="Tipo de Trastorno">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" class="flat-red" checked>
                        Activo                 
                    </label>
                </div>
            </div>

        </div>
        <!-- /.box-body -->

        <div class="box-footer">
            <div class="col-md-1">
                <button type="submit" class="btn btn-success">Registrar</button>
            </div>
            <div class="col-md-1">
                <button type="button" class="btn btn-warning">Cancelar</button>
            </div>

        </div>
    </div>

    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Tipos de Trastornos</h3>
        </div>
        <!-- /.box-header -->
        <div class="box-body">

            <table id="example2" class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Tipo</th>
                        <th>Activo</th>
                        <th>Editar</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>

        </div>
        <!-- /.box-body -->
    </div>

</asp:Content>

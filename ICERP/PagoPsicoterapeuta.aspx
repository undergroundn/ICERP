<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="PagoPsicoterapeuta.aspx.cs" Inherits="ICERP.PagoPsicoterapeuta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">

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

        function detallesPago() {
            $("#mdlPago").modal("show");
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContent" runat="server">

    <div class="box box-danger">
        <div class="box-header with-border">
            <h3 class="box-title">Pagos de Psicoterapeutas</h3>
        </div>
        <div class="box-body">
            <div>
            </div>
            <br />
            <div id="tblPsicoterapeutas">
                <table id="example2" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Nombre(s)</th>
                            <th>Paterno</th>
                            <th>Materno</th>
                            <th>Telefono</th>
                            <th>Adeudo Actual</th>
                            <th>Pagar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Carlos</td>
                            <td>Martinez</td>
                            <td>Alvarez</td>
                            <td>8343132526</td>
                            <td>$0.00</td>
                            <td>
                                <a href="#" role="button" class="btn btn-default" data-toggle="modal" onclick="detallesPago();">
                                    <span class="glyphicon glyphicon-usd" aria-hidden="true"></span>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>Ana</td>
                            <td>Vazquez</td>
                            <td>Salazar</td>
                            <td>8343153423</td>
                            <td>$250.00</td>
                            <td>
                                <a href="#" role="button" class="btn btn-default" data-toggle="modal" onclick="detallesPago();">
                                    <span class="glyphicon glyphicon-usd" aria-hidden="true"></span>
                                </a>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>

        <div class="modal fade" id="mdlPago" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width: 500px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                        <h4 class="modal-title" id="myModalLabel1">Registrar Pago</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputAdeudo" class="col-sm-4 control-label">Adeudo Total</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputAdeudo" value="$350.00" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPagado" class="col-sm-4 control-label">Pagado</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputPagado" value="$100.00" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPendiente" class="col-sm-4 control-label">Pendiente de Pago</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputPendiente" value="$250.00" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPago" class="col-sm-4 control-label">Agregar Pago</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputPago" placeholder="0.00" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary">Guardar</button>
                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Citas.aspx.cs" Inherits="ICERP.Citas" %>

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

            $('#datepicker').datepicker({
                autoclose: true
            });
        });

        function agregarCobro() {
            $("#mdlCobro").modal("show");
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContent" runat="server">

    <div class="box box-danger">
        <div class="box-header with-border">
            <h3 class="box-title">Administración de Citas</h3>
        </div>
        <div class="box-body">
            <div>
                <div class="col-sm-3">
                    <label>Consultorio</label>
                    <select class="form-control" id="sltConsultorio">
                        <option>Consultorio 1</option>
                        <option>Consultorio 2</option>
                        <option>Consultorio 3</option>
                        <option>Consultorio 4</option>
                        <option>Consultorio 5</option>
                    </select>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label>Terapeuta</label>
                        <input type="text" class="form-control" placeholder="Buscar...">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label>Paciente</label>
                        <input type="text" class="form-control" placeholder="Buscar...">
                    </div>
                </div>
                <div class="col-sm-3">
                    <label>Fecha:</label>

                    <div class="input-group date">
                        <div class="input-group-addon">
                            <i class="fa fa-calendar"></i>
                        </div>
                        <input type="text" class="form-control pull-right" id="datepicker">
                    </div>
                </div>
            </div>
            <br />
            <br />
            <br />
            <div id="tblCitas">
                <table id="example2" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Folio</th>
                            <th>Consultorio</th>
                            <th>Terapeuta</th>
                            <th>Paciente</th>
                            <th>No. Sesion</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Cobrada</th>
                            <th>Editar</th>
                            <th>Cobrar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1056</td>
                            <td>Consultorio 1</td>
                            <td>Carlos Martinez</td>
                            <td>Jose Ramirez</td>
                            <td>3</td>
                            <td>10/10/2016 10:00 am</td>
                            <td>Finalizada</td>
                            <td>Si</td>
                            <td>
                                <a href="#" role="button" class="btn btn-default" data-toggle="modal">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                </a>
                            </td>
                            <td>
                                <a href="#" role="button" class="btn btn-default" data-toggle="modal" onclick="agregarCobro();">
                                    <span class="glyphicon glyphicon-usd" aria-hidden="true"></span>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>1057</td>
                            <td>Consultorio 2</td>
                            <td>Ana Vazquez</td>
                            <td>Leticia Gomez</td>
                            <td>2</td>
                            <td>10/10/2016 12:00 pm</td>
                            <td>Iniciada</td>
                            <td>No</td>
                            <td>
                                <a href="#" role="button" class="btn btn-default" data-toggle="modal">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                </a>
                            </td>
                            <td>
                                <a href="#" role="button" class="btn btn-default" data-toggle="modal" onclick="agregarCobro();">
                                    <span class="glyphicon glyphicon-usd" aria-hidden="true"></span>
                                </a>
                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>

        <div class="modal fade" id="mdlCobro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width: 500px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                        <h4 class="modal-title" id="myModalLabel1">Registrar Cobro</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="sltPago" class="col-sm-4 control-label">Tipo de Pago</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="sltPago">
                                            <option>Efectivo</option>
                                            <option>Tarjeta</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputCantidad" class="col-sm-4 control-label">Cantidad</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputCantidad" placeholder="0.00" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="textObservaciones" class="col-sm-4 control-label">Observaciones</label>
                                    <div class="col-sm-8">
                                        <textarea class="form-control" id="textObservaciones" rows="3" placeholder="..."></textarea>
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

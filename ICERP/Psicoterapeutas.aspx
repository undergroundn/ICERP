<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Psicoterapeutas.aspx.cs" Inherits="ICERP.Psicoterapeutas" %>

<asp:Content ID="PsicoterapeutasHeadContent" ContentPlaceHolderID="headContent" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {

            ICERP_Core.llamarAjax("Psicoterapeutas.aspx/obtenerDatosControles", null, "crearControles");

            $("#btnAgregarPsico").click(function () {
                $("#mdlAgregarPsico").modal("show");
            });
        });

        //Resultado de la llamada a Psicoterapeutas.aspx/obtenerDatosControles
        function crearControles(resultado) {
            var contenido = JSON.parse(resultado);
        }

    </script>

</asp:Content>
<asp:Content ID="PsicoterapeutasBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
    <div class="box box-danger">
        <div class="box-header with-border">
            <h3 class="box-title">Registro de Psicoterapeutas</h3>
        </div>
        <div class="box-body">
            <div>
                <button id="btnAgregarPsico" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-plus"></i></span>&nbsp;&nbsp;Nuevo Psicoterapeuta</button>
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
                            <th>Turno</th>
                            <th>Cuota</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Carlos</td>
                            <td>Martinez</td>
                            <td>Alvarez</td>
                            <td>8343132526</td>
                            <td>Matutino</td>
                            <td>Fija</td>
                            <td>Activo</td>
                        </tr>
                        <tr>
                            <td>Ana</td>
                            <td>Vazquez</td>
                            <td>Salazar</td>
                            <td>8343153423</td>
                            <td>Vespertino</td>
                            <td>Flexible</td>
                            <td>Activo</td>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>

        <div class="modal fade" id="mdlAgregarPsico" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width: 500px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                        <h4 class="modal-title" id="myModalLabel1"><strong>Agrear Psicoterapeuta</strong></h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputNombre" class="col-sm-4 control-label">Nombre</label>

                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputNombre" placeholder="Nombre" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputApPaterno" class="col-sm-4 control-label">Apellido Paterno</label>

                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputApPaterno" placeholder="Apellido Paterno" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputApMaterno" class="col-sm-4 control-label">Apellido Materno</label>

                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputApMaterno" placeholder="Apellido Materno" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputTelefono" class="col-sm-4 control-label">Teléfono</label>

                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputTelefono" placeholder="Teléfono" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputWhatsApp" class="col-sm-4 control-label">WhatsApp</label>

                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputWhatsApp" placeholder="WhatsApp" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltTurno" class="col-sm-4 control-label">Turno</label>

                                    <div class="col-sm-8" id="divSltTurno">
                                        <select class="form-control" id="sltTurno">
                                            <option>Matutino</option>
                                            <option>Vespertino</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltCuota" class="col-sm-4 control-label">Cuota</label>

                                    <div class="col-sm-8" id="divSltTipoCuota">
                                        <select class="form-control" id="sltCuota">
                                            <option>Fija</option>
                                            <option>Flexible</option>
                                        </select>
                                    </div>
                                </div>
<%--                                <div class="form-group">
                                    <label>Tipos de Pacientes</label>
                                    <br />
                                    <div id="divTiposPacientes" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Tipos de Áreas</label>
                                    <br />
                                    <div id="divTiposÁreas" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Tipos de Trastornos</label>
                                    <br />
                                    <div id="divTiposTrastornos" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input id="chkActivo" type="checkbox" class="flat-red" checked />
                                    <span style="margin-right: 20px">Activo</span>
                                </div>--%>
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

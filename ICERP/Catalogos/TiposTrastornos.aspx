<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="TiposTrastornos.aspx.cs" Inherits="ICERP.Catalogos.TiposTrastornos" %>

<asp:Content ID="tipoTrastornosHeadContent" ContentPlaceHolderID="headContent" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            ICERP_Core.llamarAjax("TiposTrastornos.aspx/obtenerTiposTrastornos", null, "crearTablaTiposTrastornos");
            $("#btnRegistrarTipoTrastorno").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('registrarTipoTrastorno');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('registrarTipoTrastorno');
                    ev.preventDefault();
                    return;
                }
                guardarTipoTrastorno();
            });
            $("#btnEditarTipoTrastorno").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('editarTipoTrastorno');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('editarTipoTrastorno');
                    ev.preventDefault();
                    return;
                }
                actualizarTipoTrastorno();
            });
        });
        //Resultado de la llamada a TiposTrastornos.aspx/obtenerTiposTrastornos
        function crearTablaTiposTrastornos(resultado) {
            var contenido = JSON.parse(resultado);
            $('#tblTiposTrastornos tbody').html("");
            $.each(contenido, function (key, item) {
                var $tr = $('<tr>');
                $.each(item, function (index, data) {
                    $tr.append($('<td>').text(data));
                });
                $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnModalEditarTipoTrastorno" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
                $tr.appendTo('#tblTiposTrastornos tbody');
            });
            $("#tblTiposTrastornos").DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
                },
                "responsive": true,
                "columnDefs": [
                    { "visible": false, "targets": 0 }
                ]
            });
            clickEditarTipoTrastorno();
        }
        function guardarTipoTrastorno() {
            var nombre = $("#txtTipoTrastorno").val();
            var activo = $("#chkActivo").prop('checked');
            var tipoTrastorno = new Object();
            tipoTrastorno.Tipo = nombre;
            tipoTrastorno.Activo = activo;
            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("TiposTrastornos.aspx/guardarTipoTrastorno", "{ 'tipoTrastorno': " + JSON.stringify(tipoTrastorno) + "}", "tipoTrastornoGuardado");
        }
        //Resultado de la llamada a TiposTrastornos.aspx/guardarTipoTrastorno de la función "guardarTipoTrastorno"
        function tipoTrastornoGuardado() {
            $('#tblTiposTrastornos').DataTable().destroy();
            ICERP_Core.llamarAjax("TiposTrastornos.aspx/obtenerTiposTrastornos", null, "crearTablaTiposTrastornos");
            ICERP_Core.desbloquearPantalla();
            ICERP_Core.mostrarMensaje("Se almacenó el tipo de trastorno satisfactoriamente", "type-success");
        }
        function clickEditarTipoTrastorno() {
            $(".btnModalEditarTipoTrastorno").click(function () {
                var row = $(this).closest('tr');
                var data = $('#tblTiposTrastornos').dataTable().fnGetData(row);
                var idTipoTrastorno = Number(data[0]);
                ICERP_Core.llamarAjax("TiposTrastornos.aspx/obtenerDatosTipoTrastorno", "{ 'idTipoTrastorno': " + idTipoTrastorno + " }", "mostrarDatosTipoTrastorno");
            });
        }
        //Resultado de la llamada a TiposTrastornos.aspx/obtenerDatosTipoTrastorno de la función "clickEditarTipoTrastorno"
        function mostrarDatosTipoTrastorno(resultado) {
            var tipoTrastorno = JSON.parse(resultado);
            $("#hdnIdTipoTrastorno").val(tipoTrastorno.ID);
            $("#txtTipoTrastornoEd").val(tipoTrastorno.Tipo);
            $("#chkActivoEd").prop("checked", false);
            if (tipoTrastorno.Activo) {
                $("#chkActivoEd").prop("checked", true);
                $("#chkActivoEd").removeClass("flat-red").addClass("flat-red");
            }
            $('#mdlEditarTipoTrastorno input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });
            $("#mdlEditarTipoTrastorno").validationEngine("hideAll");
            $("#mdlEditarTipoTrastorno").modal("show");
        }
        function actualizarTipoTrastorno() {
            var idTipoTrastorno = Number($("#hdnIdTipoTrastorno").val());
            var tipo = $("#txtTipoTrastornoEd").val();
            var activo = $("#chkActivoEd").prop('checked');
            var tipoTrastorno = new Object();
            tipoTrastorno.ID = idTipoTrastorno;
            tipoTrastorno.Tipo = tipo;
            tipoTrastorno.Activo = activo;
            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("TiposTrastornos.aspx/actualizarTipoTrastorno", "{ 'tipoTrastorno': " + JSON.stringify(tipoTrastorno) + "}", "tipoTrastornoActualizado");
        }
        function tipoTrastornoActualizado() {
            $('#tblTiposTrastornos').DataTable().destroy();
            ICERP_Core.llamarAjax("TiposTrastornos.aspx/obtenerTiposTrastornos", null, "crearTablaTiposTrastornos");
            ICERP_Core.desbloquearPantalla();
            $("#mdlEditarTipoTrastorno").modal("hide");
            ICERP_Core.mostrarMensaje("Se actualizó el tipo de trastorno satisfactoriamente", "type-success");
        }
    </script>

</asp:Content>
<asp:Content ID="tipoTrastornosBodyContent" ContentPlaceHolderID="bodyContent" runat="server">

    <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Tipos de Trastornos</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="form-group">
                        <label for="txtTipoTrastorno">Tipo</label>
                        <input type="text" id="txtTipoTrastorno" style="width: 100%; max-width: 300px" maxlength="50" class="form-control validate[required]" placeholder="Nombre del Tipo de Trastorno" validgroup="registrarTipoTrastorno" />
                    </div>
                    <br />
                    <div class="form-group">
                        <input id="chkActivo" type="checkbox" class="flat-red" checked />
                        <span style="margin-right: 20px">Activo</span>
                    </div>

                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button id="btnRegistrarTipoTrastorno" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-ok"></i></span>&nbsp;&nbsp;Registrar</button>
                </div>
            </div>

            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Tipos de Trastornos</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="dataTables_wrapper form-inline dt-bootstrap">
                        <div style="width: 100%">
                            <br />
                            <table id="tblTiposTrastornos" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>IdTipoTrastorno</th>
                                        <th>Tipo</th>
                                        <th>Registró</th>
                                        <th>Fecha</th>
                                        <th>Activo</th>
                                        <th>Editar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
        </div>
    </section>

    <div class="modal fade" id="mdlEditarTipoTrastorno" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 350px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                    <h4 class="modal-title" id="myModalLabel1"><strong>Editar Tipo de Trastorno</strong></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="box-body">
                            <div class="form-group">
                                <label for="txtTipoTrastornoEd">Tipo</label>
                                <input type="text" id="txtTipoTrastornoEd" style="width: 100%; max-width: 300px" maxlength="50" class="form-control validate[required]" placeholder="Nombre del Tipo de Trastorno" validgroup="editarTipoTrastorno" />
                            </div>
                            <br />
                            <div class="form-group">
                                <input id="chkActivoEd" type="checkbox" class="flat-red" />
                                <span style="margin-right: 20px">Activo</span>
                            </div>
                            <input id="hdnIdTipoTrastorno" type="hidden" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>&nbsp;Cerrar
                    </button>
                    <button type="button" class="btn btn-primary" id="btnEditarTipoTrastorno">
                        <span class="glyphicon glyphicon-floppy-saved"></span>&nbsp;Actualizar
                    </button>
                </div>
            </div>
        </div>

    </div>

</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="TiposArea.aspx.cs" Inherits="ICERP.Catalogos.TiposArea" %>

<asp:Content ID="tipoAreasHeadContent" ContentPlaceHolderID="headContent" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {
            ICERP_Core.llamarAjax("TiposArea.aspx/obtenerTiposAreas", null, "crearTablaTiposAreas");

            $("#btnRegistrarTipoArea").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('registrarTipoArea');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('registrarTipoArea');
                    ev.preventDefault();
                    return;
                }
                guardarTipoArea();
            });

            $("#btnEditarTipoArea").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('editarTipoArea');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('editarTipoArea');
                    ev.preventDefault();
                    return;
                }
                actualizarTipoArea();
            });
        });

        //Resultado de la llamada a TiposPacientes.aspx/obtenerTiposPacientes
        function crearTablaTiposAreas(resultado) {
            var contenido = JSON.parse(resultado);
            $('#tblTiposAreas tbody').html("");
            $.each(contenido, function (key, item) {
                var $tr = $('<tr>');
                $.each(item, function (index, data) {
                    $tr.append($('<td>').text(data));
                });
                $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnModalEditarTipoArea" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
                $tr.appendTo('#tblTiposAreas tbody');
            });

            $("#tblTiposAreas").DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
                },
                "responsive": true,
                "columnDefs": [
                    { "visible": false, "targets": 0 }
                ]
            });

            clickEditarTipoArea();
        }

        function guardarTipoArea() {
            var nombre = $("#txtTipoArea").val();
            var activo = $("#chkActivo").prop('checked');

            var tipoArea = new Object();
            tipoArea.Tipo = nombre;
            tipoArea.Activo = activo;

            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("TiposArea.aspx/guardarTipoArea", "{ 'tipoArea': " + JSON.stringify(tipoArea) + "}", "tipoAreaGuardado");
        }

        //Resultado de la llamada a TiposArea.aspx/guardarTipoArea de la función "guardarTipoArea"
        function tipoAreaGuardado() {
            $('#tblTiposAreas').DataTable().destroy();
            ICERP_Core.llamarAjax("TiposArea.aspx/obtenerTiposAreas", null, "crearTablaTiposAreas");
            ICERP_Core.desbloquearPantalla();
            ICERP_Core.mostrarMensaje("Se almacenó el tipo de área satisfactoriamente", "type-success");
        }

        function clickEditarTipoArea() {
            $(".btnModalEditarTipoArea").click(function () {
                var row = $(this).closest('tr');
                var data = $('#tblTiposAreas').dataTable().fnGetData(row);
                var idTipoArea = Number(data[0]);
                ICERP_Core.llamarAjax("TiposArea.aspx/obtenerDatosTipoArea", "{ 'idTipoArea': " + idTipoArea + " }", "mostrarDatosTipoArea");
            });
        }

        //Resultado de la llamada a TiposArea.aspx/obtenerDatosTipoArea de la función "clickEditarTipoArea"
        function mostrarDatosTipoArea(resultado) {
            var tipoArea = JSON.parse(resultado);
            $("#hdnIdTipoArea").val(tipoArea.ID);
            $("#txtTipoAreaEd").val(tipoArea.Tipo);
            $("#chkActivoEd").prop("checked", false);
            if (tipoArea.Activo) {
                $("#chkActivoEd").prop("checked", true);
                $("#chkActivoEd").removeClass("flat-red").addClass("flat-red");
            }
            $('#mdlEditarTipoArea input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });
            $("#mdlEditarTipoArea").validationEngine("hideAll");
            $("#mdlEditarTipoArea").modal("show");
        }

        function actualizarTipoArea() {
            var idTipoArea = Number($("#hdnIdTipoArea").val());
            var tipo = $("#txtTipoAreaEd").val();
            var activo = $("#chkActivoEd").prop('checked');

            var tipoArea = new Object();
            tipoArea.ID = idTipoArea;
            tipoArea.Tipo = tipo;
            tipoArea.Activo = activo;

            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("TiposArea.aspx/actualizarTipoArea", "{ 'tipoArea': " + JSON.stringify(tipoArea) + "}", "tipoAreaActualizado");
        }

        function tipoAreaActualizado() {
            $('#tblTiposAreas').DataTable().destroy();
            ICERP_Core.llamarAjax("TiposArea.aspx/obtenerTiposAreas", null, "crearTablaTiposAreas");
            ICERP_Core.desbloquearPantalla();
            $("#mdlEditarTipoArea").modal("hide");
            ICERP_Core.mostrarMensaje("Se actualizó el tipo de área satisfactoriamente", "type-success");
        }

    </script>

</asp:Content>
<asp:Content ID="tipoAreasBodyContent" ContentPlaceHolderID="bodyContent" runat="server">

    <section class="content">
        <div class="row">

            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Tipos de Áreas Atendidas</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="form-group">
                        <label for="txtTipoArea">Tipo</label>
                        <input type="text" id="txtTipoArea" style="width: 100%; max-width: 300px" maxlength="50" class="form-control validate[required]" placeholder="Nombre del Tipo de Área" validgroup="registrarTipoArea" />
                    </div>
                    <br />
                    <div class="form-group">
                        <input id="chkActivo" type="checkbox" class="flat-red" checked />
                        <span style="margin-right: 20px">Activo</span>
                    </div>

                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button id="btnRegistrarTipoArea" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-ok"></i></span>&nbsp;&nbsp;Registrar</button>
                </div>
            </div>

            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Tipos de Áreas Atendidas</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="dataTables_wrapper form-inline dt-bootstrap">
                        <div style="width: 100%">
                            <br />
                            <table id="tblTiposAreas" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>IdTipoArea</th>
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

    <div class="modal fade" id="mdlEditarTipoArea" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 350px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                    <h4 class="modal-title" id="myModalLabel1"><strong>Editar Tipo de Área</strong></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="box-body">
                            <div class="form-group">
                                <label for="txtTipoAreaEd">Tipo</label>
                                <input type="text" id="txtTipoAreaEd" style="width: 100%; max-width: 300px" maxlength="50" class="form-control validate[required]" placeholder="Nombre del Tipo de Área" validgroup="editarTipoArea" />
                            </div>
                            <br />
                            <div class="form-group">
                                <input id="chkActivoEd" type="checkbox" class="flat-red" />
                                <span style="margin-right: 20px">Activo</span>
                            </div>
                            <input id="hdnIdTipoArea" type="hidden" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>&nbsp;Cerrar
                    </button>
                    <button type="button" class="btn btn-primary" id="btnEditarTipoArea">
                        <span class="glyphicon glyphicon-floppy-saved"></span>&nbsp;Actualizar
                    </button>
                </div>
            </div>
        </div>

    </div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="TipoConsultorios.aspx.cs" Inherits="ICERP.Catalogos.TipoConsultorios" %>

<asp:Content ID="tipoConsultorioHeadContent" ContentPlaceHolderID="headContent" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerTiposConsultorios", null, "crearTablaTipoConsultorios");

            $("#btnRegistrarTipoConsultorio").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('registrarTipoConsultorio');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('registrarTipoConsultorio');
                    ev.preventDefault();
                    return;
                }
                guardarTipoConsultorio();
            });

            $("#btnEditarTipoConsultorio").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('editarTipoConsultorio');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('editarTipoConsultorio');
                    ev.preventDefault();
                    return;
                }
                actualizarTipoConsultorio();
            });
        });
        
        //Resultado de la llamada a Consultorios.aspx/obtenerConsultorios
        function crearTablaTipoConsultorios(resultado) {
            var contenido = JSON.parse(resultado);
            $('#tblTiposConsultorios tbody').html("");
            $.each(contenido, function (key, item) {
                var $tr = $('<tr>');
                $.each(item, function (index, data) {
                    $tr.append($('<td>').text(data));
                });
                $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnEditarTipoConsultorio" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
                $tr.appendTo('#tblTiposConsultorios tbody');
            });

            $("#tblTiposConsultorios").DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
                },
                "responsive": true,
                "columnDefs": [
                    { "visible": false, "targets": 0 }
                ]
            });

            clickEditarTipoConsultorio();
        }

        function guardarTipoConsultorio() {
            var nombre = $("#txtTipoConsultorio").val();
            var activo = $("#chkActivo").prop('checked');

            var tipoConsultorio = new Object();
            tipoConsultorio.Tipo = nombre;
            tipoConsultorio.Activo = activo;

            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("TipoConsultorios.aspx/guardarTipoConsultorio", "{ 'tipoConsultorio': " + JSON.stringify(tipoConsultorio) + "}", "tipoConsultorioGuardado");
        }

        //Resultado de la llamada a TipoConsultorios.aspx/guardarTipoConsultorio de la función "guardarTipoConsultorio"
        function tipoConsultorioGuardado() {
            $('#tblTiposConsultorios').DataTable().destroy();
            ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerTiposConsultorios", null, "crearTablaTipoConsultorios");
            ICERP_Core.desbloquearPantalla();
            ICERP_Core.mostrarMensaje("Se almacenó el tipo de consultorio satisfactoriamente", "type-success");
        }

        function clickEditarTipoConsultorio() {
            $(".btnEditarTipoConsultorio").click(function () {
                var row = $(this).closest('tr');
                var data = $('#tblTiposConsultorios').dataTable().fnGetData(row);
                var idTipoConsultorio = Number(data[0]);
                ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerDatosTipoConsultorio", "{ 'idTipoConsultorio': " + idTipoConsultorio + " }", "mostrarDatosTipoConsultorio");
            });
        }

        //Resultado de la llamada a TipoConsultorios.aspx/obtenerDatosTipoConsultorio de la función "clickEditarConsultorio"
        function mostrarDatosTipoConsultorio(resultado) {
            var tipoConsultorio = JSON.parse(resultado);
            $("#hdnIdTipoConsultorio").val(tipoConsultorio.ID);
            $("#txtTipoConsultorioEd").val(tipoConsultorio.Tipo);
            $("#chkActivoEd").prop("checked", false);
            if (tipoConsultorio.Activo) {
                $("#chkActivoEd").prop("checked", true);
                $("#chkActivoEd").removeClass("flat-red").addClass("flat-red");
            }
            $('#mdlEditarTipoConsultorio input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });
            $("#mdlEditarTipoConsultorio").validationEngine("hideAll");
            $("#mdlEditarTipoConsultorio").modal("show");
        }

        function actualizarTipoConsultorio() {
            var idTipoConsultorio = Number($("#hdnIdTipoConsultorio").val());
            var tipo = $("#txtTipoConsultorioEd").val();
            var activo = $("#chkActivoEd").prop('checked');

            var tipoConsultorio = new Object();
            tipoConsultorio.ID = idTipoConsultorio;
            tipoConsultorio.Tipo = tipo;
            tipoConsultorio.Activo = activo;

            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("TipoConsultorios.aspx/actualizarTipoConsultorio", "{ 'tipoConsultorio': " + JSON.stringify(tipoConsultorio) + "}", "tipoConsultorioActualizado");
        }

        function tipoConsultorioActualizado() {
            $('#tblTiposConsultorios').DataTable().destroy();
            ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerTiposConsultorios", null, "crearTablaTipoConsultorios");
            ICERP_Core.desbloquearPantalla();
            $("#mdlEditarTipoConsultorio").modal("hide");
            ICERP_Core.mostrarMensaje("Se actualizó el tipo de consultorio satisfactoriamente", "type-success");
        }

    </script>
</asp:Content>
<asp:Content ID="tipoConsultorioBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
    <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Tipos de Consultorios</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="form-group">
                        <label for="txtTipoConsultorio">Tipo</label>
                        <input type="text" id="txtTipoConsultorio" style="width: 100%; max-width: 300px" maxlength="50" class="form-control validate[required]" placeholder="Nombre del Tipo de Consultorio" validgroup="registrarTipoConsultorio" />
                    </div>
                    <br />
                    <div class="form-group">
                        <input id="chkActivo" type="checkbox" class="flat-red" checked />
                        <span style="margin-right: 20px">Activo</span>
                    </div>

                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button id="btnRegistrarTipoConsultorio" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-ok"></i></span>&nbsp;&nbsp;Registrar</button>
                </div>
            </div>
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Tipos de Consultorios</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="dataTables_wrapper form-inline dt-bootstrap">
                        <div style="width: 100%">
                            <br />
                            <table id="tblTiposConsultorios" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>IdTipoConsultorio</th>
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

    <div class="modal fade" id="mdlEditarTipoConsultorio" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 350px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                    <h4 class="modal-title" id="myModalLabel1"><strong>Editar Tipo de Consultorio</strong></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="box-body">
                            <div class="form-group">
                                <label for="txtTipoConsultorioEd">Tipo</label>
                                <input type="text" id="txtTipoConsultorioEd" style="width: 100%; max-width: 300px" maxlength="50" class="form-control validate[required]" placeholder="Nombre del Tipo de Consultorio" validgroup="editarTipoConsultorio" />
                            </div>
                            <br />
                            <div class="form-group">
                                <input id="chkActivoEd" type="checkbox" class="flat-red" />
                                <span style="margin-right: 20px">Activo</span>
                            </div>
                            <input id="hdnIdTipoConsultorio" type="hidden" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>&nbsp;Cerrar
                    </button>
                    <button type="button" class="btn btn-primary" id="btnEditarTipoConsultorio">
                        <span class="glyphicon glyphicon-floppy-saved"></span>&nbsp;Actualizar
                    </button>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

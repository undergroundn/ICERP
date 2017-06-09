<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Consultorios.aspx.cs" Inherits="ICERP.Catalogos.Consultorios" %>

<asp:Content ID="consultorioHeadContent" ContentPlaceHolderID="headContent" runat="server">
    <script src="../Scripts/pages/catalogos/consultorios.js"></script>
    <script type="text/javascript">
        function PageLoad() {
            $(".select2").select2();

        };
        $(document).ready(function () {

            ICERP_Core.llamarAjax("Consultorios.aspx/obtenerConsultorios", null, "crearTablaConsultorios");

            $("#btnRegistrarConsultorio").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('registrarConsultorio');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('registrarConsultorio');
                    ev.preventDefault();
                    return;
                }
                guardarConsultorio();
            });

        });

        function crearTablaConsultorios(resultado) {
            var contenido = JSON.parse(resultado);
            $('#tblConsultorios tbody').html("");
            $.each(contenido, function (key, data) {
                var $tr = $('<tr>');
                $.each(data, function (index, data) {
                    $tr.append($('<td>').text(data));
                });
                $tr.append($('<td style="text-align:center">').html('<a id="btnEditarConsultorio" role="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
                $tr.appendTo('#tblConsultorios tbody');
            });

            $("#tblConsultorios").DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
                },
                "responsive": true,
                "columnDefs": [
                    { "visible": false, "targets": 0 }
                ]
            });
        }

        function verificarTipoConsultorio(field, rules, i, options) {
            var chkTerapias = $("#chkTerapias").prop('checked');
            var chkCursos = $("#chkCursos").prop('checked');
            if (!chkTerapias && !chkCursos) {
                $("#divTipoConsultorios").validationEngine('showPrompt', 'Seleccione el tipo de consultorio', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTipoConsultorios').validationEngine('hide');
            }
        }

        function guardarConsultorio() {
            var nombre = $("#txtNombreConsultorio").val();
            var planta = ($("#sltPlanta").val() == "1");
            var activo = $("#chkActivo").prop('checked');

            var consultorio = new Object();
            consultorio.Nombre = nombre;
            consultorio.Planta = planta;
            consultorio.Activo = activo;
            consultorio.ConsultoriosTipos = [];

            $(".tiposConsultorios").each(function() {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipo = Number($(this).val());
                    var consultorioTipo = new Object();
                    consultorioTipo.IdTipo = idTipo;
                    consultorio.ConsultoriosTipos.push(consultorioTipo);
                }
            });

            ICERP_Core.llamarAjax("Consultorios.aspx/guardarConsultorio", "{ 'consultorio': " + JSON.stringify(consultorio) + "}", "consultorioGuardado");
        }

        function consultorioGuardado(resultado) {

            $('#tblConsultorios').DataTable().destroy();
            ICERP_Core.llamarAjax("Consultorios.aspx/obtenerConsultorios", null, "crearTablaConsultorios");
        }

    </script>
</asp:Content>
<asp:Content ID="consultorioBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
    <asp:ScriptManager ID="smgPrincipal" runat="server" EnablePageMethods="True"></asp:ScriptManager>
    <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Consultorios</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="form-group">
                        <label for="txtNombreConsultorio">Nombre</label>
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtNombreConsultorio" placeholder="Nombre del Consultorio" validGroup="registrarConsultorio" />
                    </div>
                    <div class="form-group">
                        <label for="sltPlanta">Planta</label>
                        <select id="sltPlanta" class="form-control validate[required]" style="width: 100%; max-width: 300px" validGroup="registrarConsultorio">
                            <option value="">-- Seleccione --</option>
                            <option value="0">Baja</option>
                            <option value="1">Alta</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tipo</label>
                        <br />
                        <div id="divTipoConsultorios" style="display: inline-block;">
                            <input id="chkTerapias" value="1" type="checkbox" class="flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorio]]" validGroup="registrarConsultorio" />
                            <span style="margin-right: 20px">Terapias</span>
                            <input id="chkCursos" value="2" type="checkbox" class="flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorio]]" validGroup="registrarConsultorio" />
                            <span style="margin-right: 20px">Cursos</span>
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <input id="chkActivo" type="checkbox" class="flat-red" checked />
                        <span style="margin-right: 20px">Activo</span>
                    </div>
                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button id="btnRegistrarConsultorio" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-ok"></i></span>&nbsp;&nbsp;Registrar</button>
                </div>
            </div>
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Consultorios</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="dataTables_wrapper form-inline dt-bootstrap">

                        <div style="width: 100%">
                            <br />

                            <table id="tblConsultorios" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>IdConsultorio</th>
                                        <th>Nombre</th>
                                        <th>Planta</th>
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
</asp:Content>

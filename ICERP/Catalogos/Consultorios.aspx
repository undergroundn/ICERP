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

        //Resultado de la llamada a Consultorios.aspx/obtenerConsultorios
        function crearTablaConsultorios(resultado) {
            var contenido = JSON.parse(resultado);
            $('#tblConsultorios tbody').html("");
            $.each(contenido, function (key, data) {
                var $tr = $('<tr>');
                $.each(data, function (index, data) {
                    $tr.append($('<td>').text(data));
                });
                $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnEditarConsultorio" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
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

            clickEditarConsultorio();
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

            $(".tiposConsultorios").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipo = Number($(this).val());
                    var consultorioTipo = new Object();
                    consultorioTipo.IdTipo = idTipo;
                    consultorio.ConsultoriosTipos.push(consultorioTipo);
                }
            });

            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("Consultorios.aspx/guardarConsultorio", "{ 'consultorio': " + JSON.stringify(consultorio) + "}", "consultorioGuardado");
        }

        //Resultado de la llamada a Consultorios.aspx/guardarConsultorio
        function consultorioGuardado() {
            $('#tblConsultorios').DataTable().destroy();
            ICERP_Core.llamarAjax("Consultorios.aspx/obtenerConsultorios", null, "crearTablaConsultorios");
            ICERP_Core.desbloquearPantalla();
            ICERP_Core.mostrarMensaje("Se almacenó el consultorio satisfactoriamente", "type-success");
        }

        function clickEditarConsultorio() {
            $(".btnEditarConsultorio").click(function () {
                var row = $(this).closest('tr');
                var data = $('#tblConsultorios').dataTable().fnGetData(row);
                var idConsultorio = Number(data[0]);
                ICERP_Core.llamarAjax("Consultorios.aspx/obtenerDatosConsultorio", "{ 'IdConsultorio': " + idConsultorio + " }", "mostrarDatosConsultorio");
            });
        }

        function mostrarDatosConsultorio(resultado) {
            var consultorio = JSON.parse(resultado);
            $("#txtNombreConsultorioEd").val(consultorio.Nombre);
            $("#sltPlantaEd").val();
            $("#mdlEditarConsultorio").modal("show");
        }


        function verificarTipoConsultorio(field, rules, i, options) {
            var chkTerapias = $("#chkTerapias").prop('checked');
            var chkCursos = $("#chkCursos").prop('checked');
            if (!chkTerapias && !chkCursos) {
                $("#divTipoConsultorios").validationEngine('showPrompt', '* Seleccione el tipo de consultorio', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTipoConsultorios').validationEngine('hide');
            }
        }
        
        
    </script>
</asp:Content>
<asp:Content ID="consultorioBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
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
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtNombreConsultorio" placeholder="Nombre del Consultorio" validgroup="registrarConsultorio" />
                    </div>
                    <div class="form-group">
                        <label for="sltPlanta">Planta</label>
                        <select id="sltPlanta" class="form-control validate[required]" style="width: 100%; max-width: 300px" validgroup="registrarConsultorio">
                            <option value="">-- Seleccione --</option>
                            <option value="0">Baja</option>
                            <option value="1">Alta</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tipo</label>
                        <br />
                        <div id="divTipoConsultorios" style="display: inline-block;">
                            <input id="chkTerapias" value="1" type="checkbox" class="flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorio]]" validgroup="registrarConsultorio" />
                            <span style="margin-right: 20px">Terapias</span>
                            <input id="chkCursos" value="2" type="checkbox" class="flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorio]]" validgroup="registrarConsultorio" />
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

    <div class="modal fade" id="mdlEditarConsultorio" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 350px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                    <h4 class="modal-title" id="myModalLabel1">Editar Consultorio</h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="box-body">
                            <div class="form-group">
                                <label for="txtNombreConsultorioEd">Nombre</label>
                                <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtNombreConsultorioEd" placeholder="Nombre del Consultorio" validgroup="editarConsultorio" />
                            </div>
                            <div class="form-group">
                                <label for="sltPlantaEd">Planta</label>
                                <select id="sltPlantaEd" class="form-control validate[required]" style="width: 100%; max-width: 300px" validgroup="editarConsultorio">
                                    <option value="">-- Seleccione --</option>
                                    <option value="0">Baja</option>
                                    <option value="1">Alta</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Tipo</label>
                                <br />
                                <div id="divTipoConsultoriosEd" style="display: inline-block;">
                                    <input id="chkTerapiasEd" value="1" type="checkbox" class="flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorioEd]]" validgroup="editarConsultorio" />
                                    <span style="margin-right: 20px">Terapias</span>
                                    <input id="chkCursosEd" value="2" type="checkbox" class="flat-red tiposConsultorios validate[funcCall[verificarTipoConsultorioEd]]" validgroup="editarConsultorio" />
                                    <span style="margin-right: 20px">Cursos</span>
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <input id="chkActivoEd" type="checkbox" class="flat-red" />
                                <span style="margin-right: 20px">Activo</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary">Guardar</button>
                </div>
            </div>
        </div>

    </div>

</asp:Content>

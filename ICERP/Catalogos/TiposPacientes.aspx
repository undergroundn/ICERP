<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="TiposPacientes.aspx.cs" Inherits="ICERP.Catalogos.TiposPacientes" %>

<asp:Content ID="tipoPacienteHeadContet" ContentPlaceHolderID="headContent" runat="server">

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
<asp:Content ID="tipoPacienteBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
    <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Tipos de Pacientes</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label for="txtTipoPaciente">Tipo</label>
                            <input type="text" id="txtTipoPaciente" style="width: 100%; max-width: 300px" maxlength="50" class="form-control validate[required]" placeholder="Nombre del Tipo de Paciente" validgroup="registrarTipoPaciente" />
                        </div>
                        <br />
                        <div class="form-group">
                            <input id="chkActivo" type="checkbox" class="flat-red" checked />
                            <span style="margin-right: 20px">Activo</span>
                        </div>
                    </div>

                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button id="btnRegistrarTipoPaciente" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-ok"></i></span>&nbsp;&nbsp;Registrar</button>
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


</asp:Content>

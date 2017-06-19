<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="EstudioSocioeconomico.aspx.cs" Inherits="ICERP.EstudioSocioeconomico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
        <script src="../Scripts/pages/estudiosocioeconomico.js"></script>
   <%-- <script type="text/javascript">

        $(document).ready(function () {
            $('#example1').DataTable({
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
                }
            });
        });
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContent" runat="server">
      <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Estudio Socioeconómico</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label for="nombreusuario">Nombre del encuestador</label>
                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="nombreusuario" placeholder="Nombre de usuario" >
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="fecha">Fecha</label>
                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="fecha" placeholder="Fecha actual" >
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">I. Datos Generales</h3>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="nombre">Nombre</label>
                                        <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="nombre" placeholder="Nombre de paciente">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="apPaterno">Apellido Paterno</label>
                                        <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="apPaterno" placeholder="Apellido Paterno">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="apMaterno">Apellido Materno</label>
                                        <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="apMaterno" placeholder="Apellido Materno">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="calle">Domicilio, Calle</label>
                                        <input type="text" class="form-control" id="calle" placeholder="Nombre de la calle">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="numExt">No. Exterior</label>
                                        <input type="text" class="form-control" id="numExt" placeholder="número exterior">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="numInt">No. Interior</label>
                                        <input type="text" class="form-control" id="numInt" placeholder="número interior">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="colonia">Colonia</label>
                                        <input type="text" class="form-control" id="colonia" placeholder="Nombre de la colonia">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="municipio">Delegación o Municipio</label>
                                        <input type="text" class="form-control" id="municipio" placeholder="municipio">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="entrecalle">Entre la Calle</label>
                                        <input type="text" class="form-control" id="entrecalle" placeholder="entre calle">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="ycalle">Y la Calle</label>
                                        <input type="text" class="form-control" id="ycalle" placeholder="y la calle">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="estadocivil">Estado Civil</label>
                                        <input type="text" class="form-control" id="estadocivil" placeholder="soltero.. casasdo...">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="Telefonocasa">Teléfono Casa</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-phone"></i>
                                            </div>
                                            <input type="text" class="form-control" id="Telefonocasa" placeholder="Teléfono del tutor" data-inputmask='"mask": "(999) 999-9999"' data-mask>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="Telefonocelular">Teléfono Célular</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-phone"></i>
                                            </div>
                                            <input type="text" class="form-control  validate[required]" validgroup="registrarEstudioSE" id="Telefonocelular" placeholder="Teléfono del tutor" data-inputmask='"mask": "(999) 999-9999"' data-mask>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label>Trabaja Actualmente</label><br />
                                        <label>
                                            Si                 
                            <input type="radio" name="r3" id="sitra" class="flat-red" checked>
                                        </label>
                                        <label>
                                            No                 
                            <input type="radio" name="r3" id="notra" class="flat-red">
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="empresa">Empresa</label>
                                        <input type="text" class="form-control" id="empresa" placeholder="Nombre de la empresa donde labora">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="area">Área o Departamento</label>
                                        <input type="text" class="form-control" id="area" placeholder="área donde labora">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="numInt">Teléfono y horario de trabajo</label>
                                        <input type="text" class="form-control" id="telyhora" placeholder="número interior">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">II. Situación Económica Familiar</h3>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <!-- Default panel contents -->
                                        <div class="panel-heading">Ingresos</div>

                                        <!-- List group -->
                                        <ul class="list-group">
                                            <li class="list-group-item">
                                                <label for="Ingresopaciente">Paciente</label>
                                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="Ingresopaciente">
                                            </li>
                                            <li class="list-group-item">
                                                <label for="IngresoPareja">Cónyuge o Pareja</label>
                                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="IngresoPareja">
                                            </li>
                                            <li class="list-group-item">
                                                <label for="IngresoPadres">Padres</label>
                                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="IngresoPadres"></li>
                                            <li class="list-group-item">
                                                <label for="IngresoHijos">Hijos</label>
                                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="IngresoHijos"></li>
                                            <li class="list-group-item">
                                                <label for="IngresoOtros">Otros</label>
                                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="IngresoOtros"></li>
                                            <li class="list-group-item">
                                                <label for="IngresoTotal">Total</label>
                                                <input type="text" class="form-control" id="IngresoTotal"></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="panel panel-default">
                                        <!-- Default panel contents -->
                                        <div class="panel-heading">Señalar que egresos tiene</div>

                                        <!-- List group -->
                                        <ul class="list-group">
                                            <li class="list-group-item">
                                                <label> <input type="checkbox" id="chkPredial" class="flat-red">
                                                    Predial                 
                           
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                               <label> <input type="checkbox" id="chkAgua" class="flat-red">
                                                    Agua                 
                           
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label><input type="checkbox" id="chkTel" class="flat-red">
                                                    Teléfono                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkLuz" class="flat-red">
                                                    Luz                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkGas" class="flat-red">
                                                    Gas                 
                            
                                                </label>
                                            </li>
                                             <li class="list-group-item">
                                                <label><input type="checkbox" id="chkTransporte" class="flat-red">
                                                    Transporte (gasolina)                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkRenta" class="flat-red">
                                                    Renta o Hipoteca                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label><input type="checkbox" id="chkAlimentacion" class="flat-red">
                                                    Alimentación                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkEducacion" class="flat-red">
                                                    Educación                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkSalud" class="flat-red">
                                                    Salud                 
                            
                                                </label>
                                            </li>
                                             <li class="list-group-item">
                                               <label><input type="checkbox" id="chkDiversiones" class="flat-red">
                                                    Diversiones                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkOtros" class="flat-red">
                                                    Otros                 
                            
                                                </label>
                                            </li>
                                            <li class="list-group-item">
                                                <label for="egresoTotal">Total aprox. de gastos</label>
                                                <input type="text" class="form-control validate[required]" validgroup="registrarEstudioSE" id="egresoTotal"></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">III. Dependientes Económicos</h3>
                        </div>
                        <div class="panel-body">
                        <div class="row">
                             <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="nombre">Nombre</label>
                                        <input type="text" class="form-control" id="nombredep" placeholder="Nombre completo del dependiente">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="apPaterno">Parentezco</label>
                                        <input type="text" class="form-control" id="parentezcodep" placeholder="Hijo, Madre, Padre, Hermano...">
                                    </div>
                                </div>
                                
                        </div>
                        <div class="row">
                             <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="nombre">Edad</label>
                                        <input type="number" class="form-control" id="edaddep" placeholder="Edad del dependiente">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="apPaterno">Ocupación</label>
                                        <input type="text" class="form-control" id="ocupaciondep" placeholder="Ocupación del dependiente">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="apMaterno">Servicio de Salud</label>
                                        <input type="text" class="form-control" id="serviciosaluddep" placeholder="IMSS, ISSSTE, SEGURO POPULAR...">
                                    </div>
                                </div>
                              <div class="col-md-1">
                        <button type="submit" class="btn btn-primary">Agregar</button>
                    </div>
                        </div>
                            <div class"row">
                                <div class="dataTables_wrapper form-inline dt-bootstrap">
   <div align="center" style="width: 100%" >         
                <br />
                  <asp:Repeater ID="rptPerfiles" runat="server">
                    <HeaderTemplate>
                        <table id="example1" width="100%" style=" position:relative; height:200px; margin-top:10px; overflow:auto;" class="display"  bgcolor="#0066FF" >
                            <thead>
                                <tr>
                                     <th style="display:none" >
                                       Id
                                    </th>
                                  <th style="width: 10px">#</th>
                  <th>Nombre</th>
                  <th>Parentezco</th>
                  <th>Edad</th>
                    <th>Ocupación</th>
                  <th>Servicio Salud</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                             <td  style="display:none"></td>
                            <td>1.</td>
                  <td>Juan Hernández</td>
                  <td>Hijo</td>
                  <td>10 años</td>
                    <td>Estudiante</td>
                    <td>IMSS</td>
                        </tr>
                      <%--  <tr>   <td  style="display:none">
                                <%# DataBinder.Eval(Container.DataItem, "ID")%>
                            </td>
                             <td >
                                <%# DataBinder.Eval(Container.DataItem, "Tipo")%>
                            </td>  
                              
                                   <td >
                                <asp:CheckBox ID="checkBoxActivo" Checked='<%#(bool)(DataBinder.Eval(Container.DataItem, "Activo"))%>'
                                            runat="server" Enabled="false"/>
                            </td>                       
                             <td style="width: 100px;">
                                <%--        <asp:ImageButton ID="btnActualizar" runat="server" ToolTip="Actualizar"
                                            AlternateText="Actualizar Periodo" ImageUrl="~/Images/1413317624_system-software-update.png" Width="20px"
                                           OnClientClick="addIdMatch(this); return true;" OnClick="actualizarperiodo"  Height="20px"/>--%>
                                 <a href="#myModal" role="button" class="btn btn-default" data-toggle="modal" ><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
                                   </td>                                                   
                        </tr>--%>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody> </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:HiddenField ID="hfid" runat="server" />                  
            </div>
                </div>
                            </div>
                        <div class="row">
                             <table class="table table-bordered">
                <tr>
                  <th style="width: 10px">#</th>
                  <th>Nombre</th>
                  <th>Parentezco</th>
                  <th>Edad</th>
                    <th>Ocupación</th>
                  <th>Servicio Salud</th>
                </tr>
                <tr>
                  <td>1.</td>
                  <td>Juan Hernández</td>
                  <td>Hijo</td>
                  <td>10 años</td>
                    <td>Estudiante</td>
                    <td>IMSS</td>
                </tr>
              </table>
                        </div>
                            </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">IV. Datos Económicos Información de Bienes</h3>
                        </div>
                        <div class="panel-body">
                        <div class="row">
                             <div class="col-md-6">
                                    
                                        <!-- Default panel contents -->
                                       

                                        <!-- List group -->
                                        <ul class="list-group">
                                            <li class="list-group-item">
                                                <label> <input type="checkbox" id="chkautobienes" class="flat-red">
                                                    Automóvil (marca. modelo)                 
                           
                                                </label><input type="text" class="form-control" id="autobienes">
                                            </li>
                                            <li class="list-group-item">
                                               <label> <input type="checkbox" id="chkpropiedadesbienes" class="flat-red">
                                                    Propiedades (casa, terrenos)                 
                           
                                                </label><input type="text" class="form-control" id="propiedadesbienes">
                                            </li>
                                            <li class="list-group-item">
                                                <label><input type="checkbox" id="chkiversionesbienes" class="flat-red">
                                                    Inversiones (cuentas bancarias, ahorros)                 
                            
                                                </label><input type="text" class="form-control" id="inversionesbienes">
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkdeudasbienes" class="flat-red">
                                                    Deudas (tarjetas de crédito, automóvil, hipoteca, préstamos personales, etc.)                 
                            
                                                </label><input type="text" class="form-control" id="deudasbienes">
                                            </li>
                                            <li class="list-group-item">
                                               <label><input type="checkbox" id="chkotrosbienes" class="flat-red">
                                                    Otros Bienes                 
                            
                                                </label>
                                                <input type="text" class="form-control" id="definaotrosbienes">
                                            </li>
                                             
                                            
                                        </ul>
                                    
                                </div>
                        </div>
                            </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">V. Datos de la Vivienda</h3>
                        </div>
                        <div class="panel-body">
                        <div class="row">
<div class="col-md-4">
                             <div class="form-group">
                <label>Zona</label>
                <select id="sltZona" class="form-control select2" style="width: 100%;">
                  <option selected="selected">--Seleccione--</option>
                    <option >Urbana</option>
                  <option>Céntrica</option>
                  <option>Sub-Urbana</option>
                <option>Periferia</option>
                </select>
              </div></div>
                            <div class="col-md-4">
                             <div class="form-group">
                <label>Antigudad</label>
                <input type="text" class="form-control" id="antiguedadvivienda" placeholder="Antiguedad" />
                                    
              </div></div>
                            <div class="col-md-4">
                             <div class="form-group">
                <label>Vías de acceso rápidas</label>
                <input type="text" class="form-control" id="viasaccesovivienda" placeholder="accesos rápidos" />
                                    
              </div></div>

                             <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Centros Comerciales</label><br />
                                        <label>
                                            Si                 
                            <input type="radio" name="r3" id="chkSiCentrocomercial" class="flat-red">
                                        </label>
                                        <label>
                                            No                 
                            <input type="radio" name="r3" id="chkNoCentrocomercial" class="flat-red">
                                        </label><input type="text" class="form-control" id="cualescentroscomerciales" placeholder="especificar cuales centros comerciales" />
                                    </div>
                                 
                                </div>
                             <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Tiene problemas de espacio</label><br />
                                        <label>
                                            Si                 
                            <input type="radio" name="r3" id="siproblemas" class="flat-red">
                                        </label>
                                        <label>
                                            No                 
                            <input type="radio" name="r3" id="noproblemas" class="flat-red">
                                        </label><input type="text" class="form-control" id="causasespacio" placeholder="especificar causas de espacio" />
                                    </div>
                                 
                                </div>
                            <div class="col-md-8"><label>Servicios Públicos en la Zona</label><br />
                                <label> <input type="checkbox" id="agua" class="flat-red" />Agua</label>   
                                <label> <input type="checkbox" id="alumbrado" class="flat-red" />Alumbrado</label> 
                                <label> <input type="checkbox" id="drenaje" class="flat-red" />Drenaje</label>
                                <label> <input type="checkbox" id="pavimentacion" class="flat-red" />Pavimentación</label>
                                <label> <input type="checkbox" id="transportacion" class="flat-red" />Transportación</label>
                                <label> <input type="checkbox" id="areaverde" class="flat-red" />Áreas Verdes</label>
                            </div>
                            <div class="col-md-4">
                             <div class="form-group">
                <label>Condiciones generales de la vivienda (puertas, ventanaas, muros, techo, pisos, etc.)</label>
                <select id="sltcondicionesvivienda" class="form-control select2" style="width: 100%;">
                  <option selected="selected">--Seleccione--</option>
                    <option >Buena</option>
                  <option>Regular</option>
                  <option>Mala</option>                
                </select>
              </div></div>
                            <div class="col-md-4">
                             <div class="form-group">
                <label>Cuantas personas habitan el inmueble</label>
                <input type="number" class="form-control" id="personashabitantes" placeholder="cantidad de personas" />                                    
              </div></div>
                             <div class="col-md-4">
                             <div class="form-group">
                <label>Habitaciones con que cuenta la vivienda</label>
                <input type="number" class="form-control" id="habitacionescantidad" placeholder="cantidad de habitaciones" />                                    
              </div></div>
                            
                             <div class="col-md-4">
                             <div class="form-group">
                <label>Disctribución de la vivienda (especificar)</label>
                <input type="text" class="form-control" id="distribucionvivienda" placeholder="recamaras, cocina, sala, baño, otros..." />                                    
              </div></div>
                            
                        </div>
                            </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">VI. Resultados</h3>
                        </div>
                        <div class="panel-body">
                        <div class="row">
                            <div class="col-md-4">
                             <div class="form-group">
                <label>Tarifa</label>
                <input type="text" class="form-control" id="tarifa" placeholder="A/B_ C+_ C_ D+_ D_ E_" />                                    
              </div></div>
                            <div class="col-md-6">
                             <div class="form-group">
                <label>Observaciones</label>
                <input type="text" class="form-control" id="observaciones" placeholder="" />                                    
              </div></div>
                        </div>
                            </div>
                    </div>
                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <div class="col-md-1">
                        <button id="btnGuardarEstudioSE" type="submit" class="btn btn-success">Guardar</button>
                    </div>
                    <div class="col-md-1">
                        <button id="btnCancelarEstudioSE" type="button" class="btn btn-warning">Cancelar</button>
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>

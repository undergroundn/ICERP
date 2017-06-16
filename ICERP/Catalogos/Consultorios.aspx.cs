using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ICERP.Utilities;
using Model;
using Model.CustomModel;
using Model.UnitOfWork;
using Newtonsoft.Json;

namespace ICERP.Catalogos
{
    public partial class Consultorios : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Obtener los tipos de consultorio actuales para crear los controles
        [WebMethod]
        public static string obtenerTiposConsultorios()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposConsultorios = uow.TipoConsultorioRepository.Get().Where(tc => tc.Activo).Select(tc => new { tc.ID, tc.Tipo });
                return new JavaScriptSerializer().Serialize(tiposConsultorios);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Obtener el listado de consultorios para cargar la tabla
        [WebMethod]
        public static string obtenerConsultorios()
        {
            try
            {
                var spr = new StoredProcedureRepository();
                var consultorios = spr.ObtenerDetallesConsultorios().Select(c => new { c.IdConsultorio, c.NombreConsultorio, c.Planta, c.TipoConsultorio, c.UsuarioRegistro, FechaRegistro = c.FechaRegistro.ToString("dd/MM/yyyy"), Activo = c.Activo ? "Si" : "No" });
                return new JavaScriptSerializer().Serialize(consultorios);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Guardar los datos de un nuevo consultorio
        [WebMethod]
        public static void guardarConsultorio(Model.Consultorios consultorio)
        {
            try
            {
                var uow = new UnitOfWork();
                consultorio.IdUsuarioRegistro = Queries.GetCurrentUser().ID;
                consultorio.FechaRegistro = DateTime.Now;
                uow.ConsultoriosRepository.Add(consultorio);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Obtener información del consultorio a editar
        [WebMethod]
        public static string obtenerDatosConsultorio(int IdConsultorio)
        {
            try
            {
                var uow = new UnitOfWork();
                var consultorio = uow.ConsultoriosRepository.GetSingle(IdConsultorio);
                var resultado = new { consultorio.ID, consultorio.Nombre, consultorio.Planta, consultorio.Activo, Tipos = consultorio.ConsultoriosTipos.Select(c => c.IdTipo) };
                return new JavaScriptSerializer().Serialize(resultado);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Actualizar los datos de un consultorio
        [WebMethod]
        public static void actualizarConsultorio(Model.Consultorios consultorio)
        {
            try
            {
                var uow = new UnitOfWork();
                var consultorioEditar = uow.ConsultoriosRepository.GetSingle(consultorio.ID);
                consultorioEditar.Nombre = consultorio.Nombre;
                consultorioEditar.Planta = consultorio.Planta;
                consultorioEditar.Activo = consultorio.Activo;
                var idConsultoriosTipos = consultorioEditar.ConsultoriosTipos.Select(c => c.ID).ToList();
                foreach (var idConsultorioTipo in idConsultoriosTipos)
                {
                    var ct = uow.ConsultoriosTiposRepository.GetSingle(idConsultorioTipo);
                    uow.ConsultoriosTiposRepository.Delete(ct);
                }
                foreach (var consultorioTipo in consultorio.ConsultoriosTipos)
                    consultorioEditar.ConsultoriosTipos.Add(new ConsultoriosTipos { IdTipo = consultorioTipo.IdTipo, IdConsultorio = consultorioTipo.ID });
                uow.ConsultoriosRepository.UpdateSingle(consultorioEditar);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
    }
}
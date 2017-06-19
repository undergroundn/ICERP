using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ICERP.Utilities;
using Model.UnitOfWork;

namespace ICERP.Catalogos
{
    public partial class TipoConsultorios : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string obtenerTiposConsultorios()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposConsultorios = uow.TipoConsultorioRepository.Get();
                var usuarios = uow.UsuariosRepository.Get();
                var consulta = from tc in tiposConsultorios
                               join u in usuarios on tc.IdUsuario equals u.ID
                               select new { tc.ID, tc.Tipo, NombreUsuario = u.Nombres + " " + u.ApPaterno + " " + u.ApMaterno, FechaAlta = tc.FechaAlta.ToString("dd/MM/yyyy"), Activo = tc.Activo ? "Si" : "No" };
                return new JavaScriptSerializer().Serialize(consulta);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Guardar los datos de un nuevo tipo de consultorio
        [WebMethod]
        public static void guardarTipoConsultorio(Model.TipoConsultorio tipoConsultorio)
        {
            try
            {
                var uow = new UnitOfWork();
                tipoConsultorio.IdUsuario = Queries.GetCurrentUser().ID;
                tipoConsultorio.FechaAlta = DateTime.Now;
                uow.TipoConsultorioRepository.Add(tipoConsultorio);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Obtener información del tipo de consultorio a editar
        [WebMethod]
        public static string obtenerDatosTipoConsultorio(int idTipoConsultorio)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoConsultorio = uow.TipoConsultorioRepository.GetSingle(idTipoConsultorio);
                var resultado = new { tipoConsultorio.ID, tipoConsultorio.Tipo, tipoConsultorio.Activo };
                return new JavaScriptSerializer().Serialize(resultado);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Actualizar los datos de un tipo de consultorio
        [WebMethod]
        public static void actualizarTipoConsultorio(Model.TipoConsultorio tipoConsultorio)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoConsultorioEditar = uow.TipoConsultorioRepository.GetSingle(tipoConsultorio.ID);
                tipoConsultorioEditar.Tipo = tipoConsultorio.Tipo;
                tipoConsultorioEditar.Activo = tipoConsultorio.Activo;
                uow.TipoConsultorioRepository.UpdateSingle(tipoConsultorioEditar);
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
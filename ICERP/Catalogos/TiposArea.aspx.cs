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
    public partial class TiposArea : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string obtenerTiposAreas()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposAreas = uow.TipoAreasRepository.Get();
                var usuarios = uow.UsuariosRepository.Get();
                var consulta = from ta in tiposAreas
                               join u in usuarios on ta.IdUsuario equals u.ID
                               select new { ta.ID, ta.Tipo, NombreUsuario = u.Nombres + " " + u.ApPaterno + " " + u.ApMaterno, FechaAlta = ta.FechaAlta.ToString("dd/MM/yyyy"), Activo = ta.Activo ? "Si" : "No" };
                return new JavaScriptSerializer().Serialize(consulta);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Guardar los datos de un nuevo tipo de área
        [WebMethod]
        public static void guardarTipoArea(Model.TipoAreas tipoArea)
        {
            try
            {
                var uow = new UnitOfWork();
                tipoArea.IdUsuario = Queries.GetCurrentUser().ID;
                tipoArea.FechaAlta = DateTime.Now;
                uow.TipoAreasRepository.Add(tipoArea);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Obtener información del tipo de área a editar
        [WebMethod]
        public static string obtenerDatosTipoArea(short idTipoArea)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoArea = uow.TipoAreasRepository.GetSingle(idTipoArea);
                var resultado = new { tipoArea.ID, tipoArea.Tipo, tipoArea.Activo };
                return new JavaScriptSerializer().Serialize(resultado);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Actualizar los datos de un tipo de área
        [WebMethod]
        public static void actualizarTipoArea(Model.TipoAreas tipoArea)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoAreaEditar = uow.TipoAreasRepository.GetSingle(tipoArea.ID);
                tipoAreaEditar.Tipo = tipoArea.Tipo;
                tipoAreaEditar.Activo = tipoArea.Activo;
                uow.TipoAreasRepository.UpdateSingle(tipoAreaEditar);
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
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
    public partial class ResultadosEvaluacion : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Obtener el listado de consultorios para cargar la tabla
        [WebMethod]
        public static string obtenerResultados()
        {
            try
            {
                var uow = new UnitOfWork();
                var resultados = uow.ResultadosNivelSocioEconomicoRepository.Get();                   
                return new JavaScriptSerializer().Serialize(resultados);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Guardar los datos de un nuevo consultorio
        [WebMethod]
        public static void guardarResultado(Model.ResultadosNivelSocioEconomico resultado)
        {
            try
            {
                var uow = new UnitOfWork();              
                uow.ResultadosNivelSocioEconomicoRepository.Add(resultado);
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
        public static string obtenerDatosResultados(int IdResultado)
        {
            try
            {
                var uow = new UnitOfWork();
                var resultado = uow.ResultadosNivelSocioEconomicoRepository.GetSingle(IdResultado);
                //var resultado = new { consultorio.ID, consultorio.Nombre, consultorio.Planta, consultorio.Activo, Tipos = consultorio.ConsultoriosTipos.Select(c => c.IdTipo) };
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
        public static void actualizarResultados(Model.ResultadosNivelSocioEconomico resultado)
        {
            try
            {
                var uow = new UnitOfWork();
                var resultadoEditar = uow.ResultadosNivelSocioEconomicoRepository.GetSingle(resultado.ID);
                resultadoEditar.NombreTarifa = resultado.NombreTarifa;
                resultadoEditar.RangoInferior = resultado.RangoInferior;
                resultadoEditar.RangoSuperior = resultado.RangoSuperior;
                resultadoEditar.PrecioTarifa = resultado.PrecioTarifa;
                resultadoEditar.DescuentoPorPerExtra = resultado.DescuentoPorPerExtra;
                
                uow.ResultadosNivelSocioEconomicoRepository.UpdateSingle(resultadoEditar);
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
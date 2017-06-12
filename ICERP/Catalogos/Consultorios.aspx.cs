using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;
using Model.UnitOfWork;
using Newtonsoft.Json;

namespace ICERP.Catalogos
{
    public partial class Consultorios : System.Web.UI.Page
    {
        private Model.UnitOfWork.UnitOfWork _uow = new Model.UnitOfWork.UnitOfWork();
        private readonly Model.CustomModel.StoredProcedureRepository _spr = new Model.CustomModel.StoredProcedureRepository();
        protected void Page_Load(object sender, EventArgs e)
        {
            //rptPerfiles.DataSource = worker.ConsultoriosRepository.Get();
            //rptPerfiles.DataBind();

            var consultorios = _spr.ObtenerDetallesConsultorios();

        }

        [WebMethod]
        public static string obtenerConsultorios()
        {
            try
            {
                var spr = new Model.CustomModel.StoredProcedureRepository();
                var consultorios = spr.ObtenerDetallesConsultorios().Select(c => new { c.IdConsultorio, c.NombreConsultorio, c.Planta, c.TipoConsultorio, c.UsuarioRegistro, FechaRegistro = c.FechaRegistro.ToString("dd/MM/yyyy"), Activo = c.Activo ? "Si" : "No" });
                return new JavaScriptSerializer().Serialize(consultorios);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [WebMethod]
        public static void guardarConsultorio(Model.Consultorios consultorio)
        {
            try
            {
                var uow = new UnitOfWork();
                consultorio.IdUsuarioRegistro = 1;
                consultorio.FechaRegistro = DateTime.Now;
                uow.ConsultoriosRepository.Add(consultorio);
                uow.Save();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

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
            catch (Exception)
            {

                throw;
            }
        }
    }
}
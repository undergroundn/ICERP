﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Model
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class IcerpEntities : DbContext
    {
        public IcerpEntities()
            : base("name=IcerpEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<CatColonia> CatColonia { get; set; }
        public virtual DbSet<CatEstado> CatEstado { get; set; }
        public virtual DbSet<CatMunicipio> CatMunicipio { get; set; }
        public virtual DbSet<CatPais> CatPais { get; set; }
        public virtual DbSet<CatRoles> CatRoles { get; set; }
        public virtual DbSet<CobroConsulta> CobroConsulta { get; set; }
        public virtual DbSet<CostosConsultasFijas> CostosConsultasFijas { get; set; }
        public virtual DbSet<DatosGeneralesES> DatosGeneralesES { get; set; }
        public virtual DbSet<DatosViviendaES> DatosViviendaES { get; set; }
        public virtual DbSet<DependientesEconomicosES> DependientesEconomicosES { get; set; }
        public virtual DbSet<Dias> Dias { get; set; }
        public virtual DbSet<DisponibilidadConsultorios> DisponibilidadConsultorios { get; set; }
        public virtual DbSet<DisponibilidadPsicoterapeuta> DisponibilidadPsicoterapeuta { get; set; }
        public virtual DbSet<DomicilioES> DomicilioES { get; set; }
        public virtual DbSet<EstatusCitas> EstatusCitas { get; set; }
        public virtual DbSet<EstudioSocioeconomico> EstudioSocioeconomico { get; set; }
        public virtual DbSet<Fechas> Fechas { get; set; }
        public virtual DbSet<HorarioPsicoterapeuta> HorarioPsicoterapeuta { get; set; }
        public virtual DbSet<Horarios> Horarios { get; set; }
        public virtual DbSet<InformacionBienesES> InformacionBienesES { get; set; }
        public virtual DbSet<Logs> Logs { get; set; }
        public virtual DbSet<Menu> Menu { get; set; }
        public virtual DbSet<PagoTerapeutas> PagoTerapeutas { get; set; }
        public virtual DbSet<Permisos> Permisos { get; set; }
        public virtual DbSet<ResultadosNivelSocioEconomico> ResultadosNivelSocioEconomico { get; set; }
        public virtual DbSet<SaldoIcerp> SaldoIcerp { get; set; }
        public virtual DbSet<TipoAccion> TipoAccion { get; set; }
        public virtual DbSet<TipoPago> TipoPago { get; set; }
        public virtual DbSet<TrabajoActualES> TrabajoActualES { get; set; }
        public virtual DbSet<Tutores> Tutores { get; set; }
        public virtual DbSet<MenuUsuario> MenuUsuario { get; set; }
        public virtual DbSet<Consultorios> Consultorios { get; set; }
        public virtual DbSet<TipoConsultorio> TipoConsultorio { get; set; }
        public virtual DbSet<ConsultoriosTipos> ConsultoriosTipos { get; set; }
        public virtual DbSet<PsicoterapeutasTiposAreas> PsicoterapeutasTiposAreas { get; set; }
        public virtual DbSet<PsicoterapeutasTiposPacientes> PsicoterapeutasTiposPacientes { get; set; }
        public virtual DbSet<PsicoterapeutasTiposTrastornos> PsicoterapeutasTiposTrastornos { get; set; }
        public virtual DbSet<Usuarios> Usuarios { get; set; }
        public virtual DbSet<TipoAreas> TipoAreas { get; set; }
        public virtual DbSet<TipoPaciente> TipoPaciente { get; set; }
        public virtual DbSet<TipoTrastorno> TipoTrastorno { get; set; }
        public virtual DbSet<TipoCouta> TipoCouta { get; set; }
        public virtual DbSet<Turnos> Turnos { get; set; }
        public virtual DbSet<Derivado> Derivado { get; set; }
        public virtual DbSet<Pacientes> Pacientes { get; set; }
        public virtual DbSet<Psicoterapeuta> Psicoterapeuta { get; set; }
        public virtual DbSet<Citas> Citas { get; set; }
    
        public virtual ObjectResult<getCredencialesUsuario_Result> getCredencialesUsuario(string nombreUsuario, string pwd)
        {
            var nombreUsuarioParameter = nombreUsuario != null ?
                new ObjectParameter("nombreUsuario", nombreUsuario) :
                new ObjectParameter("nombreUsuario", typeof(string));
    
            var pwdParameter = pwd != null ?
                new ObjectParameter("pwd", pwd) :
                new ObjectParameter("pwd", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<getCredencialesUsuario_Result>("getCredencialesUsuario", nombreUsuarioParameter, pwdParameter);
        }
    
        public virtual ObjectResult<spObtenerDetallesConsultorios_Result> spObtenerDetallesConsultorios()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spObtenerDetallesConsultorios_Result>("spObtenerDetallesConsultorios");
        }
    }
}

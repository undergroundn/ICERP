//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Turnos
    {
        public Turnos()
        {
            this.Pacientes = new HashSet<Pacientes>();
            this.Psicoterapeuta = new HashSet<Psicoterapeuta>();
        }
    
        public int ID { get; set; }
        public string Turno { get; set; }
        public Nullable<bool> Activo { get; set; }
    
        public virtual ICollection<Pacientes> Pacientes { get; set; }
        public virtual ICollection<Psicoterapeuta> Psicoterapeuta { get; set; }
    }
}

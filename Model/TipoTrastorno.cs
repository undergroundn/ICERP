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
    
    public partial class TipoTrastorno
    {
        public TipoTrastorno()
        {
            this.Psicoterapeuta = new HashSet<Psicoterapeuta>();
        }
    
        public short ID { get; set; }
        public string Tipo { get; set; }
        public bool Activo { get; set; }
        public System.DateTime FechaAlta { get; set; }
        public int IdUsuario { get; set; }
    
        public virtual ICollection<Psicoterapeuta> Psicoterapeuta { get; set; }
    }
}

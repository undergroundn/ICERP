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
    
    public partial class MenuUsuario
    {
        public short Id_MenuUsuario { get; set; }
        public int IdUsuario { get; set; }
        public int IdMenu { get; set; }
        public bool Activo { get; set; }
    
        public virtual Menu Menu { get; set; }
        public virtual Usuarios Usuarios { get; set; }
    }
}

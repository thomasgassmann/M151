//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TaobaoExpress.DataAccess
{
    using System;
    using System.Collections.Generic;
    
    public partial class ProductReview
    {
        public long Id { get; set; }
        public long ProductId { get; set; }
        public string Text { get; set; }
        public string UserEmail { get; set; }
        public int Review { get; set; }
        public System.DateTime Created { get; set; }
    
        public virtual Product Products { get; set; }
    }
}

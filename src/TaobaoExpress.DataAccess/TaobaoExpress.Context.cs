﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class TaobaoExpressEntities : DbContext
    {
        public TaobaoExpressEntities()
            : base("name=TaobaoExpressEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AuditLog> AuditLog { get; set; }
        public virtual DbSet<ProductReview> ProductReviews { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<RelatedProduct> RelatedProducts { get; set; }
        public virtual DbSet<RetailerProduct> RetailerProducts { get; set; }
        public virtual DbSet<Retailer> Retailers { get; set; }
    }
}

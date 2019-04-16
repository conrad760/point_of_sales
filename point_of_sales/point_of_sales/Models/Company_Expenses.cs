namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Company_Expenses
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Company_Expenses()
        {
            Products = new HashSet<Product>();
        }

        [Key]
        public int expenses_id { get; set; }

        public int supplier_id { get; set; }

        public int employee_id { get; set; }

        public int product_id { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal cost { get; set; }

        [Column(TypeName = "date")]
        public DateTime order_date { get; set; }

        public int quantity_purchased { get; set; }

        public virtual Employee Employee { get; set; }

        public virtual Product Product { get; set; }

        public virtual Supplier Supplier { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Product> Products { get; set; }
    }
}

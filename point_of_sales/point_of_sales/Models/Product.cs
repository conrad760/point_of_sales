namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Product()
        {
            Company_Expenses = new HashSet<Company_Expenses>();
            Order_details = new HashSet<Order_details>();
            Reviews = new HashSet<Review>();
        }

        [Key]
        public int product_id { get; set; }

        [Required]
        [StringLength(30)]
        public string product_name { get; set; }

        public int supplier_id { get; set; }

        public int category_id { get; set; }

        public int units_in_stock { get; set; }

        [Column(TypeName = "smallmoney")]
        public decimal price { get; set; }

        public int perishable { get; set; }

        [Column(TypeName = "date")]
        public DateTime exp_date { get; set; }

        public virtual Category Category { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Company_Expenses> Company_Expenses { get; set; }

        public virtual Company_Expenses Company_Expenses1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order_details> Order_details { get; set; }

        public virtual Supplier Supplier { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Review> Reviews { get; set; }
    }
}

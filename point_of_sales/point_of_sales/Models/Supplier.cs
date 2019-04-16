namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Supplier
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Supplier()
        {
            Company_Expenses = new HashSet<Company_Expenses>();
            Products = new HashSet<Product>();
        }

        [Key]
        public int supplier_id { get; set; }

        [Required]
        [StringLength(30)]
        public string supplier_name { get; set; }

        [Required]
        [StringLength(30)]
        public string supplier_email { get; set; }

        [Required]
        [StringLength(30)]
        public string supplier_phone_number { get; set; }

        public int category_id { get; set; }

        public virtual Category Category { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Company_Expenses> Company_Expenses { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Product> Products { get; set; }
    }
}

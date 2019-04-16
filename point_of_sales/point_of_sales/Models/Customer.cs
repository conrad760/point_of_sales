namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            Invoices = new HashSet<Invoice>();
            Reviews = new HashSet<Review>();
            Rewards = new HashSet<Reward>();
        }

        [Key]
        public int customer_id { get; set; }

        [Required]
        [StringLength(30)]
        public string customer_first_name { get; set; }

        [Required]
        [StringLength(30)]
        public string customer_last_name { get; set; }

        [Required]
        [StringLength(30)]
        public string customer_email { get; set; }

        [Required]
        [StringLength(30)]
        public string phone_number { get; set; }

        [Column(TypeName = "date")]
        public DateTime date_of_birth { get; set; }

        public int created_by { get; set; }

        public virtual Employee Employee { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Invoice> Invoices { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Review> Reviews { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Reward> Rewards { get; set; }
    }
}

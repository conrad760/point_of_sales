namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Employee
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Employee()
        {
            Company_Expenses = new HashSet<Company_Expenses>();
            Customers = new HashSet<Customer>();
            Employees1 = new HashSet<Employee>();
            Invoices = new HashSet<Invoice>();
        }

        [Key]
        public int employee_id { get; set; }

        [Required]
        [StringLength(30)]
        public string employee_email { get; set; }

        [Required]
        [StringLength(30)]
        public string employee_first_name { get; set; }

        [Required]
        [StringLength(30)]
        public string employee_last_name { get; set; }

        public int employee_access_code { get; set; }

        [Column(TypeName = "date")]
        public DateTime employee_data_of_birth { get; set; }

        [Column(TypeName = "date")]
        public DateTime date_hired { get; set; }

        public int hired_by_id { get; set; }

        public int hours_per_week { get; set; }

        [Required]
        [StringLength(1)]
        public string sex { get; set; }

        public virtual Access_level Access_level { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Company_Expenses> Company_Expenses { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Customer> Customers { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Employee> Employees1 { get; set; }

        public virtual Employee Employee1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}

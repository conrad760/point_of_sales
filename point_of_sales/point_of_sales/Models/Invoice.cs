namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Invoice
    {
        [Key]
        public int invoice_id { get; set; }

        public int customer_id { get; set; }

        public int employee_id { get; set; }

        [Column(TypeName = "date")]
        public DateTime invoice_date { get; set; }

        public virtual Customer Customer { get; set; }

        public virtual Employee Employee { get; set; }
    }
}

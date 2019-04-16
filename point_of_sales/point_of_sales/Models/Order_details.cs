namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Order_details
    {
        [Key]
        public int order_id { get; set; }

        public int product_id { get; set; }

        public int quantity { get; set; }

        public decimal discount { get; set; }

        public int invoice_id { get; set; }

        public virtual Product Product { get; set; }
    }
}

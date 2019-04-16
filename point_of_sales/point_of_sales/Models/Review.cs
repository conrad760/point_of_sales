namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Review
    {
        [Key]
        public int review_id { get; set; }

        public int product_id { get; set; }

        public int customer_id { get; set; }

        public int rating { get; set; }

        public virtual Customer Customer { get; set; }

        public virtual Product Product { get; set; }
    }
}

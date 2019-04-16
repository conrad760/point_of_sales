namespace point_of_sales
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Reward
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int reward_id { get; set; }

        public int customer_id { get; set; }

        public int points { get; set; }

        public virtual Customer Customer { get; set; }
    }
}

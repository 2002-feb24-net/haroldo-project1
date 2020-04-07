﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Restaurant.DataAccess.Model
{
    public partial class Products
    {
        public Products()
        {
            Inventorys = new HashSet<Inventorys>();
            Orderlines = new HashSet<Orderlines>();
        }

        public int ProductId { get; set; }

        [Required]
        [Display(Name = "Product")]
        public string ProductName { get; set; }
        [DataType(DataType.Currency)]
        [Required]
        public decimal? Cost { get; set; }

        public virtual ICollection<Inventorys> Inventorys { get; set; }
        public virtual ICollection<Orderlines> Orderlines { get; set; }
    }
}

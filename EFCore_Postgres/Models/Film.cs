using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EFCore_Postgres.Models
{
    [Table("film", Schema="public")]
    public class Film
    {
        [Column("film_id")]
        [Key]
        public int ID { get; set; }

        [Column("title")]
        public string Title { get; set; }

    }
}

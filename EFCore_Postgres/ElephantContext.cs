using Microsoft.EntityFrameworkCore;

namespace EFCore_Postgres
{
    public class ElephantContext: DbContext
    {
        public ElephantContext(DbContextOptions<ElephantContext> options)
            : base(options)
        {
        }

        public DbSet<Models.Film> Films { get; set; }
    }
}

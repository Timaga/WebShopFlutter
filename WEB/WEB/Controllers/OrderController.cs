using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Text;
using WEB.Models;

namespace WEB.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : Controller
    {
        [HttpGet]
        [Route("select")]
        public IActionResult Select(int id_customer)
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            List<order> departments = new List<order>();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var command = new NpgsqlCommand("select * from orders", connection);
                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                   

                    var department = new order
                    {
                        id = reader.GetInt32(0), 
                        id_customer = reader.GetInt32(1),
                        id_product = reader.GetInt32(2),
                    };
                    if (id_customer == reader.GetInt32(1))
                    {
                        departments.Add(department);
                    }
                }
                connection.Close();
            }
            return Ok(departments);
        }

        [HttpPost]
        [Route("add")]
        public IActionResult Insert(int customer_id, int product_id)
        {
            
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var command = new NpgsqlCommand("insert into orders (customer_id, product_id) values (@customer_id, @product_id)", connection);
                command.Parameters.AddWithValue("customer_id", customer_id);
                command.Parameters.AddWithValue("product_id", product_id);               
                command.ExecuteNonQuery();
                connection.Close();
            }
            return Ok(true);
        }
    }
}

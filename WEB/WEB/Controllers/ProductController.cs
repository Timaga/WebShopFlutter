using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Text;
using WEB.Models;

namespace WEB.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : Controller
    {
        [HttpGet]
        [Route("select")]
        public IActionResult Select()
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            List<Product> departments = new List<Product>();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var command = new NpgsqlCommand("select * from products", connection);
                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    byte[] fileBytes = reader.IsDBNull(3) ? null : reader.GetFieldValue<byte[]>(3);

                    string fileContent = Encoding.UTF8.GetString(fileBytes);


                    var department = new Product
                    {
                        id = reader.GetInt32(0),
                        title = reader.GetString(1),
                        price = reader.GetFloat(2),
                        photo = reader.IsDBNull(3) ? null : reader.GetFieldValue<byte[]>(3),
                        category = reader.GetString(4),
                    };

                    departments.Add(department);
                }
                connection.Close();
            }
            return Ok(departments);
        }
        [HttpGet]
        [Route("GetById")]
        public IActionResult GetByid( int id)
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            List<Product> departments = new List<Product>();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var command = new NpgsqlCommand("select * from products", connection);
                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    byte[] fileBytes = reader.IsDBNull(3) ? null : reader.GetFieldValue<byte[]>(3);

                    string fileContent = Encoding.UTF8.GetString(fileBytes);


                    var department = new Product
                    {
                        id = reader.GetInt32(0),
                        title = reader.GetString(1),
                        price = reader.GetFloat(2),
                        photo = reader.IsDBNull(3) ? null : reader.GetFieldValue<byte[]>(3),
                        category = reader.GetString(4),
                    };
                    if (id == department.id)
                    {
                        departments.Add(department);
                    }
                }
                connection.Close();
            }
            return Ok(departments);
        }

        [HttpPost]
        [Route("insert")]
        public IActionResult Insert(string title, float price, IFormFile photo,string category)
        {
            byte[] imageBytes;
            using (var memoryStream = new MemoryStream())
            {
                photo.CopyTo(memoryStream);
                imageBytes = memoryStream.ToArray();
            }
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var command = new NpgsqlCommand("insert into products (title, price, photo,category) values (@title, @price, @photo,@category)", connection);
                command.Parameters.AddWithValue("title", title);
                command.Parameters.AddWithValue("price", price);
                command.Parameters.AddWithValue("photo", imageBytes);
                command.Parameters.AddWithValue("category", category);
                command.ExecuteNonQuery();
                connection.Close();
            }
            return Ok(true);
        }
    }
}


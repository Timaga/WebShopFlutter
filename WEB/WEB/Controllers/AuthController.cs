using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Text;
using WEB.Models;

namespace WEB.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : Controller
    {
        [HttpGet]
        [Route("select")]
        public IActionResult Select()
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            List<auth> departments = new List<auth>();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var command = new NpgsqlCommand("select * from auth", connection);
                var reader = command.ExecuteReader();
                while (reader.Read())
                {

                    var department = new auth
                    {
                        id = reader.GetInt32(0),
                        login = reader.GetString(1),
                        password = reader.GetString(2),
 
                    };
                    departments.Add(department);
                }
                connection.Close();
            }
            return Ok(departments);
        }

        [HttpPost]
        [Route("insert")]
        public IActionResult Insert(string login, string password)
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var checkCommand = new NpgsqlCommand("select count(*) from auth where login = @login", connection);
                checkCommand.Parameters.AddWithValue("login", login);
                var existingCount = (Int64)checkCommand.ExecuteScalar();

                if (existingCount > 0)
                {
                    
                    return BadRequest("Логин уже существует");
                }
                var command = new NpgsqlCommand("insert into auth (login,password) values (@login,@password)", connection);
                command.Parameters.AddWithValue("login", login);
                command.Parameters.AddWithValue("password", password);
                command.ExecuteNonQuery();
                connection.Close();
            }
            return Ok(true);
        }
    }
}

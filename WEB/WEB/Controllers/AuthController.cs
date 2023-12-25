using Microsoft.AspNetCore.Identity;
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

        [HttpPost]
        [Route("login")]
        public IActionResult Login(string login, string password)
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var checkCommand = new NpgsqlCommand("select count(*) from auth where login = @login", connection);
                checkCommand.Parameters.AddWithValue("login", login);
                var existingCount = (Int64)checkCommand.ExecuteScalar();

                if (existingCount == 0)
                {

                    return BadRequest("Логин не существует");
                }
                var checkCommand1 = new NpgsqlCommand("SELECT password FROM auth WHERE login = @login", connection);
                checkCommand1.Parameters.AddWithValue("login", login);             
                var passwordFromDB = (string)checkCommand1.ExecuteScalar();
                if (!passwordFromDB.Equals(password))
                {
                    return BadRequest("Неверный пароль");
                }
                connection.Close();
            }
            var configuration1 = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            List<auth> departments = new List<auth>();
            using (var connection1 = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection1.Open();
                var command1 = new NpgsqlCommand("select * from auth", connection1);
                var reader1 = command1.ExecuteReader();
                while (reader1.Read())
                {

                    var department = new auth
                    {
                        id = reader1.GetInt32(0),
                        login = reader1.GetString(1),

                    };
                    if (department.login == login)
                    {
                        departments.Add(department);
                        return Ok(reader1.GetInt32(0));
                    }
                }
                connection1.Close();
            }
            return Ok(true);
        }


        [HttpGet]
        [Route("selectById")]
        public IActionResult SelectById(int id)
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
                    if (id == department.id)
                    {
                        departments.Add(department);
                    }
                }
                connection.Close();
            }
            return Ok(departments);
        }
    }
}

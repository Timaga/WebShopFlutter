using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Text;
using WEB.Models;

namespace WEB.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LogsContoller : ControllerBase
    {

        [HttpGet]
        [Route("select")]
        public IActionResult Select()
        {
            var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
            List<Logs> departments = new List<Logs>();
            using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();
                var command = new NpgsqlCommand("select * from log", connection);
                var reader = command.ExecuteReader();
                while (reader.Read())
                {
                    byte[] fileBytes = reader.IsDBNull(3) ? null : reader.GetFieldValue<byte[]>(3);
                    
                        string fileContent = Encoding.UTF8.GetString(fileBytes);
                        
                    
                    var department = new Logs
                    {
                        id = reader.GetInt32(0),
                        ip = reader.GetString(1),
                        data = reader.GetDateTime(2),                  
                        route = reader.GetString(4),
                        message = fileContent,
                    };
                    departments.Add(department);
                }
                connection.Close();
            }
            return Ok(departments);
        }

        [HttpPost]
            [Route("insert")]
            public IActionResult Insert(string message,string ip,string route)
            {
                var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
                using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
                {
                    connection.Open();
                string filePath = "log.txt"; 
                System.IO.File.WriteAllText(filePath, message);
                byte[] fileBytes = System.IO.File.ReadAllBytes(filePath);
                var command = new NpgsqlCommand("insert into log (ip,data,message,route) values (@ip,@data,@message,@route)", connection);                  
                command.Parameters.AddWithValue("ip", ip);
                command.Parameters.AddWithValue("data", DateTime.Now);
                command.Parameters.AddWithValue("message", fileBytes);
                command.Parameters.AddWithValue("route", route);
                command.ExecuteNonQuery();
                    connection.Close();
                }
                return Ok(true);
            }

           
        }
    }

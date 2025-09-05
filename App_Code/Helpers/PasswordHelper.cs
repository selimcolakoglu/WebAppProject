using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for PasswordHelper
/// </summary>
public class PasswordHelper
{
    public static string HashPassword(string password)
    {
        if (string.IsNullOrEmpty(password)) return "";

        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(password);
            byte[] hash = sha256.ComputeHash(bytes);
            return BitConverter.ToString(hash).Replace("-", "").ToLowerInvariant();
        }
    }

    public static bool VerifyPassword(string inputPassword, string hashedPassword)
    {
        string inputHash = HashPassword(inputPassword);
        return inputHash == hashedPassword;
    }
}
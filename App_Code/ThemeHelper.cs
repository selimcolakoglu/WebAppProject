using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;

/// <summary>
/// Summary description for ThemeHelper
/// </summary>
public class ThemeHelper
{
    /// <summary>
    /// Belirtilen path’teki UserControl’ü yükler, placeholder’a ekler ve kontrolü döner.
    /// </summary>
    public static Control LoadSection(Page page, PlaceHolder placeholder, string controlPath)
    {
        var ctrl = page.LoadControl(controlPath);
        ctrl.ID = Path.GetFileNameWithoutExtension(controlPath);
        placeholder.Controls.Clear();
        placeholder.Controls.Add(ctrl);
        return ctrl;
    }

    public static string ThemeName
    {
        get
        {
            return HttpContext.Current.Session["Theme"] as string ?? "B2BTheme1";
        }
        set
        {
            HttpContext.Current.Session["Theme"] = value;
        }
    }

    public static string ThemeAdminName
    {
        get
        {
            return HttpContext.Current.Session["AdminTheme"] as string ?? "B2BTheme";
        }
        set
        {
            HttpContext.Current.Session["AdminTheme"] = value;
        }
    }
}
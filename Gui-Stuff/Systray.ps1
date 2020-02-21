<# 
    .Notes
    Simple systray app template.
#>

#Import assemblies
Add-Type -AssemblyName System.Windows.Forms, PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()

# Create Icon
$b64 = 
"thisisab64iconhas...."

# Process Icon.
$Bitmap               = New-Object System.Windows.Media.Imaging.BitmapImage
$Bitmap.BeginInit()
$Bitmap.StreamSource  = [System.IO.MemoryStream][System.Convert]::FromBase64String($b64)
$Bitmap.EndInit()
$Bitmap.Freeze()
$Image                = [System.Drawing.Bitmap][System.Drawing.Image]::FromStream($Bitmap.StreamSource)
$Icon                 = [System.Drawing.Icon]::FromHandle($Image.GetHicon())

# Define Form parameters.
$Form                 = New-Object System.Windows.Forms.Form
$Form.Icon            = $Icon
$Form.Height          = "285"
$Form.Width           = "380"
$Form.Text            = "Computer info"
$Form.StartPosition   = "Manual"
$Form.ShowInTaskbar   = $false
$Form.MinimizeBox     = $false
$Form.MaximizeBox     = $false
$Form.FormBorderStyle = "FixedDialog"

# Create NotifyIcon.
$NotifyIcon                                             = New-Object System.Windows.Forms.NotifyIcon
$NotifyIcon.Text                                        = "PC info"
$NotifyIcon.Icon                                        = $Icon
$NotifyIcon.Visible                                     = $true

# Create context menu.
$ContextMenu                                            = New-Object System.Windows.Forms.ContextMenu
$NotifyIcon.ContextMenu                                 = $ContextMenu

# Create context menu Exit button.
$ExitButton                                             = New-Object System.Windows.Forms.MenuItem
$ExitButton.Text                                        = "Exit"
$NotifyIcon.ContextMenu.MenuItems.AddRange($ExitButton)

function DrawWindow {
    $x = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width - $Form.Width
    $y = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height - $Form.Height
    $Form.Location = New-Object System.Drawing.Point($x, $y)
    $Form.ShowDialog()
}

function CloseWindow {
    $NotifyIcon.Visible = $false
    $Form.Close()
    Stop-Process $pid
}

# Click event for the NotifyIcon.
$NotifyIcon.Add_Click({ 
    DrawWindow
})

# Click event for Exit button.
$ExitButton.Add_Click({ CloseWindow })

# Minimise form to task tray when it loses focus.
$Form.Add_Deactivate({ $Form.Hide() })

# Garbage collector.
[System.GC]::Collect()

# Create an application context.
$AppContext = New-Object System.Windows.Forms.ApplicationContext
[void][System.Windows.Forms.Application]::Run($AppContext)

break

#################### I now have some good data, but my end users will never open a PowerShell to get to it.
#################### Are you sure? hmmmm, you might be right, but lets give it a try.

# Give me some data to work with
start .\Files\SampleData.csv
$myData = Import-Csv -Path .\Files\SampleData.csv

########################
#    PowerShell RAW    #
########################

#Display my data in the console
$myData | Select-Object -first 20 | Format-List
# hmmmm not very readable, try it again
$myData | Select-Object -first 20 | Format-List 'statecode','county','line','construction'
# maybe in a table
$myData | Select-Object -first 20 | Format-Table 'statecode','county','line','construction'
# Are you sure this view won't work? ok lets try something else

########################
#    PowerShell OGV    #
########################

$myData | Select-Object -first 20 | Out-GridView # look for a new window with the data
# you like the filters?
$myData | Select-Object -first 20 | Out-GridView -PassThru # Select a couple of records and click the OK button
$myData | Select-Object -first 20 | Out-GridView -PassThru | Format-Table 'statecode','county','line','construction'
#kinda feels like Excel right? yeah still has some work to be done

###################
#       CSV       #
###################

$myData | Select-Object -first 20 | Out-GridView -PassThru | Export-Csv -Path .\Files\SomeCSVData.csv -NoTypeInformation
code .\Files\SomeCSVData.csv

###################
#      EXCEL      #
###################

# Do not blink moving forward, this is where things start getting very interesting.
#reminder about the data we are working with ---> 9200+ rows
start .\Files\SampleData.csv

$myData | Export-Excel -Path .\Files\MyNewExcelFile.xlsx -Show -AutoSize -AutoFilter -BoldTopRow -FreezeTopRow
# I bet you can't make the above with 50 lines of code in a macro  ;)

#Conditional formating
$cf = New-ConditionalText -Text 'CLAY COUNTY' -ConditionalTextColor Red -BackgroundColor White -PatternType None
$myData | Export-Excel -Show -AutoSize -AutoFilter -BoldTopRow -FreezeTopRow -ConditionalFormat $cf

# Pivot tables and Graphs?
$myData | Export-Excel -IncludePivotTable -PivotRows 'county' -PivotColumns 'construction' -PivotData @{'hu_site_limit'='Count'} -IncludePivotChart -ChartType ColumnStacked
$myData | Where-Object 'county' -like '*LA*' | Export-Excel -IncludePivotTable -PivotRows 'county' -PivotColumns 'construction' -PivotData @{'hu_site_limit'='Count'} -IncludePivotChart -ChartType ColumnStacked


##################
#      HTML      #
##################

$myData | Where-Object 'county' -like '*LA*' | ConvertTo-Html | Out-File .\Files\HTMLData.html -Force
start .\Files\HTMLData.html
#Not very readable but ok
$myData | Where-Object 'county' -like '*LA*' | Select-Object 'statecode','county','line','construction' | ConvertTo-Html | Out-File .\Files\HTMLData.html -Force
start .\Files\HTMLData.html

######################
#      DIAGRAMS      #
######################

#Let draw some data
$filteredData = $myData | Where-Object 'county' -like '*LA*' | Select -First 5
Graph {

    node $filteredData.'line' @{shape='rect'}
    rank $filteredData.'line'

    node $filteredData.'construction' @{shape='octagon'}
    rank $filteredData.'construction'

    edge $filteredData.'line' -To $filteredData.'construction'

} | Show-PSGraph

# Network Connections
$netstat = Get-NetTCPConnection

graph network @{rankdir='LR'}  {
    Node @{shape='rect'}

    $EdgeParam = @{
        Node       = $netstat
        FromScript = {$_.LocalAddress}
        ToScript   = {$_.RemoteAddress}
        Attributes = @{label={'{0}:{1}' -f $_.LocalPort,$_.RemotePort}}
    }
    Edge @EdgeParam
} | Show-PSGraph

# Lets get somethign a little more real world
$netstat = Get-NetTCPConnection | where LocalAddress -LIKE '192.168.*'
$process = Get-Process | where id -in $netstat.OwningProcess

graph network @{rankdir='LR'} {
    node @{shape='rect'}
    node $process -NodeScript {$_.ID} @{label={$_.ProcessName}}

    $netParam = @{
        Node = $netstat
        FromScript = {$_.OwningProcess}
        ToScript   = {$_.RemoteAddress}
        Attributes = @{label={'{0}:{1}' -f $_.LocalPort,$_.RemotePort}}
    }
    edge @netParam
} | Show-PSGraph

###########################
#      WINDOWS FORMS      #
###########################

# WINDOWS FORMS - Example 1

Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form
$Form.Height = 200
$Form.Width = 400

$Form.ShowDialog()

# WINDOWS FORMS - Example 2

Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form
$Form.Height = 200
$Form.Width = 400

$Label1             = New-Object system.Windows.Forms.Label
$Label1.text        = "Click the button to get OS details"
$Label1.AutoSize    = $true
$Label1.width       = 25
$Label1.height      = 10
$Label1.location    = New-Object System.Drawing.Point(20,40)
$Label1.Font        = 'Microsoft Sans Serif,10'

$Form.controls.AddRange($Label1)

$Form.ShowDialog()

# WINDOWS FORMS - Example 3

Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form
$Form.Height = 200
$Form.Width = 400

$Label1             = New-Object system.Windows.Forms.Label
$Label1.text        = "Click the button to get OS details"
$Label1.AutoSize    = $true
$Label1.width       = 25
$Label1.height      = 10
$Label1.location    = New-Object System.Drawing.Point(20,40)
$Label1.Font        = 'Microsoft Sans Serif,10'

$TextBox1           = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline = $false
$TextBox1.width     = 300
$TextBox1.height    = 20
$TextBox1.location  = New-Object System.Drawing.Point(20,80)
$TextBox1.Font      = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($Label1,$TextBox1))

$Form.ShowDialog()

# WINDOWS FORMS - Example 4

Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form
$Form.Height = 200
$Form.Width = 400

$Label1             = New-Object system.Windows.Forms.Label
$Label1.text        = "Click the button to get OS details"
$Label1.AutoSize    = $true
$Label1.width       = 25
$Label1.height      = 10
$Label1.location    = New-Object System.Drawing.Point(20,40)
$Label1.Font        = 'Microsoft Sans Serif,10'

$TextBox1           = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline = $false
$TextBox1.width     = 300
$TextBox1.height    = 20
$TextBox1.location  = New-Object System.Drawing.Point(20,80)
$TextBox1.Font      = 'Microsoft Sans Serif,10'

$Button1            = New-Object system.Windows.Forms.Button
$Button1.text       = "Click Here!"
$Button1.width      = 80
$Button1.height     = 30
$Button1.location   = New-Object System.Drawing.Point(257,34)
$Button1.Font       = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($Label1,$TextBox1,$Button1))

$Button1.Add_Click({ $TextBox1.Text = (Get-WmiObject win32_OperatingSystem).Caption; })

$Form.ShowDialog()

##################
#      WPF       #
##################

Add-Type -AssemblyName PresentationFramework
[xml]$xaml =
@"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Presto" Height="350" Width="525">
    <Grid>
        <TextBox HorizontalAlignment="Left" Height="36" Margin="67,59,0,0" TextWrapping="Wrap" Text="TextBox" VerticalAlignment="Top" Width="247"/>
        <Button Content="Buscar" HorizontalAlignment="Left" Margin="343,59,0,0" VerticalAlignment="Top" Name="btnBuscar" Width="99" Height="36"/>
        <Label Content="Nombre o Folio" HorizontalAlignment="Left" Margin="146,28,0,0" VerticalAlignment="Top" Width="auto"/>
        <GroupBox Header="Datos de Empleado" HorizontalAlignment="Left" Margin="19,121,0,0" VerticalAlignment="Top" Height="190" Width="295">
            <Label Content="Juan Perez Gonzalo" HorizontalAlignment="Left" Margin="106,20,0,0" VerticalAlignment="Top"/>
        </GroupBox>
        <ListBox HorizontalAlignment="Left" Height="179" Margin="338,132,0,0" VerticalAlignment="Top" Width="170">
            <Button Content="Carlos Slim | 3254" Height="Auto" Width="auto"/>
            <Button Content="Gael Garcia | 5486" Height="Auto" Width="Auto "/>
        </ListBox>
        <Image HorizontalAlignment="Left" Height="74" Margin="47,145,0,0" VerticalAlignment="Top" Width="65" Source="C:\Projects\Presto\Images\Man.png"/>
        <Label Content="3245" HorizontalAlignment="Left" Margin="192,193,0,0" VerticalAlignment="Top"/>
        <Label Content="Folio:" HorizontalAlignment="Left" Margin="146,193,0,0" VerticalAlignment="Top"/>
        <Label Content="14-Mayo-2016 12:23:43 PM" HorizontalAlignment="Left" Margin="85,245,0,0" VerticalAlignment="Top"/>
    </Grid>
</Window>
"@

Function OS()
{
    Get-WmiObject -Class Win32_OperatingSystem | ogv
}

$reader=(New-Object System.Xml.XmlNodeReader $xaml)
$Window=[Windows.Markup.XamlReader]::Load( $reader )
$btnBuscar = $Window.FindName('btnBuscar')
$MtdBtnBuscar = $btnBuscar.add_click
$MtdBtnBuscar.Invoke({OS})

$Window.ShowDialog() | Out-Null

#######################
#       WEB SITE      #
#######################

#Universal Dashboard
start https://ironmansoftware.com/powershell-universal-dashboard/


code '.\1 - Intro.md'

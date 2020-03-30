<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    youtube-dl-gui
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '530,368'
$Form.text                       = "Download do youtube"
$Form.TopMost                    = $false

$TextBox1                        = New-Object system.Windows.Forms.TextBox
$TextBox1.multiline              = $true
$TextBox1.width                  = 516
$TextBox1.height                 = 192
$TextBox1.location               = New-Object System.Drawing.Point(7,7)
$TextBox1.Font                   = 'Microsoft Sans Serif,10'

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.enabled                = $false
$TextBox2.multiline              = $true
$TextBox2.width                  = 516
$TextBox2.height                 = 95
$TextBox2.location               = New-Object System.Drawing.Point(7,210)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "download"
$Button1.width                   = 517
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(7,328)
$Button1.Font                    = 'Microsoft Sans Serif,10'

$RadioButton1                    = New-Object system.Windows.Forms.RadioButton
$RadioButton1.Checked            = $true
$RadioButton1.text               = "Musica"
$RadioButton1.AutoSize           = $true
$RadioButton1.width              = 104
$RadioButton1.height             = 20
$RadioButton1.location           = New-Object System.Drawing.Point(13,305)
$RadioButton1.Font               = 'Microsoft Sans Serif,10'

$RadioButton2                    = New-Object system.Windows.Forms.RadioButton
$RadioButton2.text               = "Video"
$RadioButton2.AutoSize           = $true
$RadioButton2.width              = 104
$RadioButton2.height             = 20
$RadioButton2.location           = New-Object System.Drawing.Point(102,305)
$RadioButton2.Font               = 'Microsoft Sans Serif,10'

$Button1.Add_Click({ Button-Click })

Function Button-Click {	
	$i = 0
	$c = $TextBox1.Lines.Count
	$musica = $RadioButton1.Checked 
	foreach($line in $TextBox1.Lines) {
		$i++
		Add-Log-List("$i/$c - $line`r`n")
		
		if($musica) {
			Download-Musica($line)
		} else {
			Download-Video($line)
		}
	}
	
	Clear-Download-List
}

Function Add-Log-List($log) {
	Write-Host $log
	$TextBox2.Text += $log
}

Function Clear-Download-List {
	$TextBox1.Text = ""
}

Function Download-Musica($link) {
	$youtubedl = '.\youtube-dl'
	$params = "$link -i --extract-audio --audio-format mp3 --audio-quality 0 -o %userprofile%\Downloads\%(title)s-%(id)s.%(ext)s"
	start $youtubedl $params
}

Function Download-Video($link) {

	$youtubedl = '.\youtube-dl'
	$params = "$link -f 18 -o %userprofile%\Downloads\%(title)s-%(id)s.%(ext)s"
	start $youtubedl $params
}

$Form.controls.AddRange(@($TextBox1,$TextBox2,$Button1,$RadioButton1,$RadioButton2))

[void]$Form.ShowDialog()
# Load necessary assembly for creating form
Add-Type -AssemblyName System.Windows.Forms

# Function to convert input string to double
function ConvertTo-Double {
    param (
        [Parameter(Mandatory=$true)]
        [string]$inputString
    )
    
    $culture = [System.Globalization.CultureInfo]::InvariantCulture
    if ($inputString.Contains(",")) {
        $culture = [System.Globalization.CultureInfo]::CreateSpecificCulture('de-DE')
    }
    return [double]::Parse($inputString, $culture)
}

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Hourly Wage Calculator'
$form.Size = New-Object System.Drawing.Size(300,250)
$form.StartPosition = 'CenterScreen'

# Create salary label and textbox
$grossSalaryLabel = New-Object System.Windows.Forms.Label
$grossSalaryLabel.Location = New-Object System.Drawing.Point(10,20)
$grossSalaryLabel.Size = New-Object System.Drawing.Size(280,20)
$grossSalaryLabel.Text = 'Enter your total gross monthly salary :'
$form.Controls.Add($grossSalaryLabel)

$grossSalaryTextBox = New-Object System.Windows.Forms.TextBox
$grossSalaryTextBox.Location = New-Object System.Drawing.Point(10,40)
$grossSalaryTextBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($grossSalaryTextBox)

# Create net salary label and textbox
$netSalaryLabel = New-Object System.Windows.Forms.Label
$netSalaryLabel.Location = New-Object System.Drawing.Point(10,70)
$netSalaryLabel.Size = New-Object System.Drawing.Size(280,20)
$netSalaryLabel.Text = 'Enter your total net monthly salary :'
$form.Controls.Add($netSalaryLabel)

$netSalaryTextBox = New-Object System.Windows.Forms.TextBox
$netSalaryTextBox.Location = New-Object System.Drawing.Point(10,90)
$netSalaryTextBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($netSalaryTextBox)

# Create hours label and textbox
$hoursLabel = New-Object System.Windows.Forms.Label
$hoursLabel.Location = New-Object System.Drawing.Point(10,120)
$hoursLabel.Size = New-Object System.Drawing.Size(280,20)
$hoursLabel.Text = 'Enter the number of hours you work per week:'
$form.Controls.Add($hoursLabel)

$hoursTextBox = New-Object System.Windows.Forms.TextBox
$hoursTextBox.Location = New-Object System.Drawing.Point(10,140)
$hoursTextBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($hoursTextBox)

# Create button for calculation
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10,170)
$button.Size = New-Object System.Drawing.Size(75,23)
$button.Text = 'Calculate'
$button.Add_Click({
    $weeksPerMonth = 4.33 # average number of weeks in a month

    $monthlyGrossSalary = ConvertTo-Double $grossSalaryTextBox.Text
    $monthlyNetSalary = ConvertTo-Double $netSalaryTextBox.Text
    $hoursPerWeek = ConvertTo-Double $hoursTextBox.Text

    $hoursPerMonth = $hoursPerWeek * $weeksPerMonth

    $hourlyGrossWage = $monthlyGrossSalary / $hoursPerMonth
    $hourlyNetWage = $monthlyNetSalary / $hoursPerMonth

    [System.Windows.Forms.MessageBox]::Show("Your gross hourly wage is: CHF " + $hourlyGrossWage.ToString('F2') + "`nYour net hourly wage is: CHF " + $hourlyNetWage.ToString('F2'), "Hourly Wage")
})
$form.Controls.Add($button)

# Run the form
$form.ShowDialog()

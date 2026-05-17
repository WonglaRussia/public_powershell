#cd 'F:\Camera\NIKON D5300\DCIM'
$files = Get-ChildItem -Recurse -File
$files | ForEach-Object -Process {
   $name_match = [regex]::Match($_.Name, '^(?<BODY>.*?)(?=\.[\w]+\z)((?<EXTENTION>\.[\w]+\z))')
   $name_body = $name_match[0].Groups['BODY'].Value
   $extention = $name_match[0].Groups['EXTENTION'].Value
   $date_stg = ($_.LastWriteTime).ToString("dd-MM-yyyy_HH-mm-ss") -replace '(?<=^\d{2}-\d{2}-\d{4})_', '_time_'
   $new_name = $date_stg + '_' + $name_body + $extention
   $new_name
   $_ | Rename-Item -NewName $new_name
}
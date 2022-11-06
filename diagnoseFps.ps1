Write-Host "Running.. press ctrl+c to stop process"
while($true) {
	Add-Content -Path diagnostics.txt -Value (Get-Date)
	$cpu = (Get-Counter '\Processor(_Total)\% Processortid').CounterSamples.CookedValue
	Add-Content -Path diagnostics.txt -Value "CPU: $([math]::Round($cpu,2))%"
	$GpuUseTotal = (((Get-Counter "\GPU Engine(*engtype_3D)\Utilization Percentage").CounterSamples | where CookedValue).CookedValue | measure -sum).sum
	Add-Content -Path diagnostics.txt -Value "GPU: $([math]::Round($GpuUseTotal,2))%"
	$CompObject =  Get-WmiObject -Class WIN32_OperatingSystem
	$Memory = ((($CompObject.TotalVisibleMemorySize - $CompObject.FreePhysicalMemory)*100)/ $CompObject.TotalVisibleMemorySize)	
	Add-Content -Path diagnostics.txt -Value "RAM: $([math]::Round($Memory,2))%"
	$Counter = 0
	$UsedBandwidth = do {
	$counter ++
		(Get-CimInstance -Query "Select BytesTotalPersec from Win32_PerfFormattedData_Tcpip_NetworkInterface" | Select-Object BytesTotalPerSec).BytesTotalPerSec[1] / 1Mb * 8
	} while ($counter -le 10)

	$AvgBandwidth = [math]::round(($UsedBandwidth | Measure-Object -Average).average, 2)
	Add-Content -Path diagnostics.txt -Value "AvgBandwidth: $AvgBandwidth Mbit`n"
	Start-Sleep -Seconds 2
}
# gamingDiagnostics

GamingDiagnostics is a small script for sampling computer hardware utilization.
 It was created to be able to diagnose my sons PC in order to figure out which hardware unit in the PC was guilty of low FPS.

 Just run the script before gaming, start gaming, and note the time where the game lags and compare to the timestamped entries in the created ```diagnostics.txt``` file.

 You might need to tweak the script a little as I found out that

 ```(Get-CimInstance -Query "Select BytesTotalPersec from Win32_PerfFormattedData_Tcpip_NetworkInterface" | Select-Object BytesTotalPerSec).BytesTotalPerSec[1]```

 ..was dependent on which machine I executed the script on - ie. the array index [1] might need to be [0] instead. Just try by executing in the powershell terminal and you'll figure it out.

 ## Usage

 Just download ```diagnoseFps.ps1``` go to the download path in a powershell terminal/window and execute:

 ```shell
 PS C:\projects\gamingDiagnostics> .\diagnoseFps.ps1
 ```

 The diagnostics.txt file will hold entries for each sampled set that looks like:

 ```txt
 06-11-2022 20:34:05
CPU: 3.74%
GPU: 0.27%
RAM: 63.53%
AvgBandwidth: 0 Mbit
```

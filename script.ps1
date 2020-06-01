#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned



#Variables
[xml]$VMLIST = Get-Content .\vms.xml



function start_rdp ($i){
  $ip = $VMLIST.VirtualMachinesList.list.vm.Item($i).ip
  $username = $VMLIST.VirtualMachinesList.defaultUsername
  $password = $VMLIST.VirtualMachinesList.defaultPassword
  Write-Host "Launching VM: " $VMLIST.VirtualMachinesList.list.vm.Item($i).name $VMLIST.VirtualMachinesList.list.vm.Item($i).ip $VMLIST.VirtualMachinesList.list.vm.Item($i).description

  Start-Process "$env:windir\system32\cmdkey.exe" -ArgumentList " /add:$ip /user:$username /pass:$password"
  Start-Process "$env:windir\system32\mstsc.exe" -ArgumentList "/v:$ip"
}

function showVMSinConfig {
  clear
  Write-Host "Current Virtual Machines in config file`n"
  For ($i=0; $i -lt  $VMLIST.VirtualMachinesList.list.vm.length; $i++) {
    Write-Host "[$i]"  $VMLIST.VirtualMachinesList.list.vm.Item($i).name $VMLIST.VirtualMachinesList.list.vm.Item($i).ip $VMLIST.VirtualMachinesList.list.vm.Item($i).description

  }



  Write-Host "`nSidenote: To add more, edit vms.xml file"
}

function RDPchooseVM {
  showVMSinConfig
  $choice = Read-Host "Which VM do you choose to connect with? [Select number]"
  Write-Host ""
  start_rdp ($choice)
}







#main
RDPchooseVM

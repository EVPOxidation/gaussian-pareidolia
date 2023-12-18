    1..50 | %{
        convert -size 1280x720 xc:'rgb(117,90,131)' +noise gaussian ./tmp/$_.jpg #This will give it a purple-ish RGB filter, if you wish to use a black and white background,
        mogrify -strip -gaussian-blur 0.01 -quality 75% .\tmp\$_.jpg             #replace xc:'rgb(x,y,z)' with xc:grey
        Write-Host "Frame " $_ "generated"                                       #The frames here will be numbered 1 - 50. 
    }

    magick -delay 0 -loop 0 .\tmp\*.jpg .\tmp\1.gif #Compiles each frame into 1.gif
    Remove-Item -Path .\tmp\*.jpg                   #Removes the jpgs that were generated as they're no longer neccisary 
    Write-Host "BACKGROUND GENERATED"
    magick .\tmp\1.gif -coalesce -fuzz 4% +dither -remap .\tmp\1.gif[0] -layers Optimize .\tmp\2.gif  # Here, in these two lines the 
    gifsicle -i .\tmp\2.gif -O3 --colors 64 -o pareidolia.gif                                         # gif is optimized, otherwise it'd take up way too much space. 
    Write-Host "GIF OPTIMIZED"
    Remove-Item -Path .\tmp\*.gif    #The gif is originally output as pareidolia.gif so that gaussian.gif won't be written to during it's creation,
    move pareidolia.gif gaussian.gif #doing so messes thebackground if you're using something like Lively Wallpaper.

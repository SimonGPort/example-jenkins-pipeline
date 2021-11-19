
def updateVersionFile($1){

def versionApp(){
    echo 'inside versionAPP'
    return $1
}

return versionApp

}

return this
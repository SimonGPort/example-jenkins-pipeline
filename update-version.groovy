def updateVersionFile(new_version){
echo "${new_version}"
return "versionApp(){ return ${new_version} }"
}

return this
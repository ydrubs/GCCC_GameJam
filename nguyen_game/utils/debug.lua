function Log(message)
    printh(message, "debug.txt")
end

function Log(message, overwrite)
    printh(message, "debug.txt", overwrite)
end
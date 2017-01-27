var fs = require('fs');
const execSync = require('child_process').execSync;
var data = require('./data.json');

function exec(command, env) {
    console.log(command);
    execSync(command,
        {
            "env": env,
            "stdio": [null, process.stdout, process.stderr]
        });
}

function deployDocker(item) {
    console.log("Deploy Docker - " + item.name);
    exec("docker pull " + item.image);

    var hostName = ("" + execSync('hostname')).trim();
    var hostIp = ("" + execSync("ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'")).trim();
    
    var env = {
        "HOST_IP" : hostIp,
        "HOST_NAME" : hostName
    }

    for (var envName in item.environment) {
        env[envName] = item.environment[envName];
    }

    var runCmd = "docker run";
    runCmd += " --name " + item.name;

    for (var portIndex in item.ports) {
        var x = item.ports[portIndex];
        runCmd += " -p 0.0.0.0:" + x.port + ":" + x.port + "/" + x.protocol;
    }

    for (var paramIndex in item.arguments) {
        var x = item.arguments[paramIndex];
        runCmd += " " + x;
    }

    runCmd += " " + item.image;
    exec(runCmd, env);
}

function executeCommand(item) {
    console.log("Execute Command - " + item.name);
    exec(item.command, item.environment);
}

for (var index in data) {
    var item = data[index];

    if (item.image) {
        deployDocker(item);
    }
    else if (item.command) {
        executeCommand(item);
    }
    else {
        console.log("Invalid item[" + index + "] " + item.name);
    }

    console.log("");
}
const hyprland = await Service.import('hyprland')

const minSize = 275


// Function to get gaps
function getGapsOut(callback) {
    exec('hyprctl getoption general:gapsout', (error, stdout, stderr) => {
        if (error) {
            console.error(`Error getting gaps out: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`Error: ${stderr}`);
            return;
        }
        // Parse the output to get the gap values
        const gaps = parseGaps(stdout);
        callback(gaps);
    });
}

function getGapsIn(callback) {
    exec('hyprctl getoption general:gapsin', (error, stdout, stderr) => {
        if (error) {
            console.error(`Error getting gaps in: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`Error: ${stderr}`);
            return;
        }
        // Parse the output to get the gap values
        const gaps = parseGaps(stdout);
        callback(gaps);
    });
}



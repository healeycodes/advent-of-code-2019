const fs = require('fs');
const filename = process.argv[2];

const intcodeProgram = input => {
    const program = input.split(',').map(num => parseInt(num));

    // Restore state
    program[1] = 12;
    program[2] = 2;

    for (let i = 0; i < program.length; i += 4) {
        const opCode = program[i];
        const first = program[program[i+1]];
        const second = program[program[i+2]];
        const storeAt = program[i+3];
        switch (opCode) {
            case 1:
                program[storeAt] = first + second;
                break;
            case 2:
                program[storeAt] = first * second;
                break;
            case 99:
                console.log(program[0]);
                process.exit();
                break;
            default:
                console.log(program[0]);
                process.exit();
                break;
        }
    }
}

fs.readFile(filename, 'utf8', (err, data) => {
    if (err) throw err;
    intcodeProgram(data);
});

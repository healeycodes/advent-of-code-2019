const fs = require('fs');
const filename = process.argv[2];

const intcodeProgram = (program, noun, verb) => {

    // Restore state
    program[1] = noun;
    program[2] = verb;

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
                return program[0];
                break;
            default:
                return program[0];
                break;
        }
    }
}

const getOutput = (data, desiredOutput=19690720) => {
    const program = data.split(',').map(num => parseInt(num));

    for (let i = 0; i < 99; i++) {
        for (let j = 0; j < 99; j++) {
            if (intcodeProgram(program.slice(), i, j) === desiredOutput) {
                return 100 * i + j;
            }
        }
    }

    throw "Couldn't find desired output"
}

fs.readFile(filename, 'utf8', (err, data) => {
    if (err) throw err;
    console.log(getOutput(data));
});

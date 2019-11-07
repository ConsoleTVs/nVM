import strformat

# The memory size.
const MemorySize = 32

# Represents the kind of the opcode.
type OpcodeKind = enum
    Loadi, # Loadi rx l1
    Addi, # Addi rx ra l1
    Compare, # Compare rx ra rb
    Jump, # Jump l1
    Branch, # Branch ra l1
    Exit # Exit

# Represents an opcode with 3 operands.
type Opcode = object
    kind: OpcodeKind
    op1: int64
    op2: int64
    op3: int64

proc main() =
    var memory: array[MemorySize, int64]
    const code = [
        Opcode(kind: Loadi, op1: 0, op2: 1000000000), # r0 = 1000000000;
        Opcode(kind: Loadi, op1: 1, op2: 0), # r1 = 0;
        Opcode(kind: Compare, op1: 2, op2: 0, op3: 1), # r2 = r0 == r1;
        Opcode(kind: Branch, op1: 2, op2: 2), # if (r2 == 0) goto +2;
        Opcode(kind: Addi, op1: 1, op2: 1, op3: 1), # r0 = r0 + 1;
        Opcode(kind: Jump, op1: -4), # goto -4;
        Opcode(kind: Exit)
    ]
    var pc: int64 = 0
    while true:
        let op = code[pc]
        case op.kind
            of Loadi:
                memory[op.op1] = op.op2
            of Addi:
                memory[op.op1] = memory[op.op2] + op.op3
            of Compare:
                memory[op.op1] = int(memory[op.op2] == memory[op.op3])
            of Jump:
                pc += op.op1
            of Branch:
                if memory[op.op1] != 0:
                    pc += op.op1
            of Exit:
                break
        pc.inc
    echo(fmt"Result: {memory[0]}")
main()

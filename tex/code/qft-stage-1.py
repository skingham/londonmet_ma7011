qft_c = QuantumCircuit(3)
# Hadamard gate is constructed with the 'QuantumCircuit.h' method
qft_c.h(2)
# CROT from qubit 1 to qubit 2
qft_c.cp(pi/2, 1, 2)
# CROT from qubit 2 to qubit 0
qft_c.cp(pi/4, 0, 2) 
qft_c.draw()

from qiskit_ibm_runtime import QiskitRuntimeService

# Save an IBM Quantum account and set it as your default account.
api_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx...x'
QiskitRuntimeService.save_account(channel="ibm_quantum",
                                  token=api_token, set_as_default=True)

# Load saved credentials
service = QiskitRuntimeService()

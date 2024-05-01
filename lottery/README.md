# Provably Random Raffle Smart Contract

## Overview

This project contains a smart contract for conducting a provably random raffle on the Ethereum blockchain. It leverages blockchain technology to ensure fairness, transparency, and security in the drawing process, making it impossible to predict or manipulate the outcome.

## Features

- **Provably Random Selection**: Utilizes a combination of block hashes and a secure off-chain random number generator to ensure the randomness of the raffle draw.
- **Transparent Process**: All transactions and the selection process are recorded on the blockchain, available for anyone to verify.
- **Automated Payouts**: Winners are automatically paid out to their Ethereum addresses, reducing the need for manual intervention and increasing trust.

## How It Works

1. **Initialization**: The raffle is initialized with a set number of tickets and a drawing date.
2. **Participation**: Participants can purchase tickets by sending ETH to the contract address until the sale period ends.
3. **Drawing**: Once the drawing date is reached, the contract automatically performs the random selection of winners.
4. **Payout**: Winners are immediately sent their winnings directly to their wallets.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/en/) and npm installed.
- An Ethereum wallet with ETH for deploying and interacting with the contract.

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Install dependencies:
   ```bash
   cd <project-directory>
   npm install
   ```

### Deployment

To deploy the raffle contract to an Ethereum network, follow these steps:

1. Compile the contract:
   ```bash
   forge build
   ```
2. Deploy the contract using Foundry:
   ```bash
   forge create src/YourRaffleContract.sol:YourRaffleContract --rpc-url <your-rpc-url>
   ```

Replace `<your-rpc-url>` with the RPC URL of the Ethereum network you wish to deploy to (e.g., mainnet, Rinkeby, etc.).

## Testing

To run the tests included in the project:

```bash
forge test
```

Ensure all tests pass to verify the contract's functionality.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues to suggest improvements or report bugs.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Special thanks to the Ethereum community for providing the tools and frameworks used in this project.
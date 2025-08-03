# 🧮 zk-Sum-Product Circuit

This project demonstrates a basic zk-SNARK setup using Circom and SnarkJS. It proves that you know two private inputs `a` and `b` such that their **sum and product** are correctly computed, without revealing `a` and `b`.

### Tools to have
- rustup 

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup default stable

To check install successfully: rustc version
```

- NodeJS (https://nodejs.org/en/download)
- Circom

```
git clone https://github.com/iden3/circom.git

cd circom

cargo build release

export PATH="$PATH:$(pwd)/target/release"

(to make it permenant, `nano ~/.zshrc` to add full path, `source ~/.zshrc` to apply changes)

To check install successfully: circom --version
```

- snarkjs (Install globally)
```bash
npm install -g snarkjs
```

## 🛠️ Setup Steps
### 1. Compile the circuit

```bash
circom circuits/sum_product.circom --r1cs --wasm --sym -o outputs
```

### 2. Download Powers of Tau file

```bash
wget https://storage.googleapis.com/zkevm/ptau/powersOfTau28_hez_final_10.ptau -O outputs/pot10.ptau
```

### 3. Generate proving and verification keys

```bash
snarkjs groth16 setup outputs/sum_product.r1cs outputs/pot10.ptau outputs/sum_product_final.zkey
```

### 4. Export verification key

```bash
snarkjs zkey export verificationkey outputs/sum_product_final.zkey outputs/verification_key.json
```

### 5. Create input file

`inputs/input.json`:

```json
{
  "a": 3,
  "b": 4
}
```

### 6. Generate the witness

```bash
node outputs/sum_product_js/generate_witness.js outputs/sum_product_js/sum_product.wasm inputs/input.json outputs/witness.wtns
```

### 7. Generate the proof

```bash
snarkjs groth16 prove outputs/sum_product_final.zkey outputs/witness.wtns outputs/proof.json outputs/public.json
```

### 8. Verify the proof

```bash
snarkjs groth16 verify outputs/verification_key.json outputs/public.json outputs/proof.json
```

You should see:

```
[INFO]  snarkJS: OK!
```

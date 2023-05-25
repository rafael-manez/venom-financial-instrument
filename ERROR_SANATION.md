#SOLVED USUAL ERRORS:

#[ERROR]  path: /home/venom/venom-financial-instruments/companyShares/contracts/Sample.tsol, contractFile: Sample. error: /bin/sh: 1: /home/venom/.cache/locklift-nodejs/compiler/0_62_0/solc_0_62_0_linux: not found  
#[SOLVED] locklift.config.js update path: o compiler version: or user .env
## ¬NODEJS_COMPILER="0.68.0"
## NODEJS_COMPILER_PATH=/TON-Solidity-Compiler/build/solc/solc

 
#[ERROR] Error: You can't provide linker version without compiler version!
#[SOLVE] Intasll linker_tvm from tonlabs repository and at locklift.config.js update linker: path:
##TVM_LINKER_LIB_PATH="/home/venom/TON-Solidity-Compiler/lib/stdlib_sol.tvm"
##TVM_LINKER_PATH="/home/venom/TVM-linker/target/release/tvm_linker"

#[ERROR]  path: /home/venom/venom-financial-instruments/companyShares/contracts/Sample.tsol, contractFile: Sample. error: --include-path option requires a non-empty base path.
#[SOLVE]  Add --disable-include-path at locklift test --network local --config....  --disable-include-path
#locklift test --network local --config $WORKSPACE/$PROJECT_NAME/locklift.config.ts --disale-include-path

#[BUILDER]  Warning: Visibility for constructor is ignored. If you want the contract to be non-deployable, making it "abstract" is sufficient.
#[SOLVE] Usally is a public contructor of contracts, these parameters cannot be assigned valid values from outside but only through the constructor of derived contracts. Add the modifier abstract to contract and remove modifier public from constructor.
 

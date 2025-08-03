pragma circom 2.0.0;

template SumProduct() {

    // Declaration of signals
    signal input a;
    signal input b;

    signal output sum;
    signal output product;

    // Constraints - the operation that are going to perform via input (+/x)
    sum <== a + b;
    product <== a * b;
}

component main = SumProduct();



const Netflix = artifacts.require("Netflix");

module.exports = function(deployer) {
    deployer.deploy(Netflix, "0x1E3bC04b4f0c0fc3662BFA6f15a42D0565cEceA8", 1);
    };

    